import 'package:flutter/material.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/components/wordModel.dart';
import 'package:motus_clone/constants/status.dart';
import 'package:motus_clone/data/keyStatus.dart';
import 'package:motus_clone/data/validWordsToPlayWith.dart';

class Controller extends ChangeNotifier {
  String _correctWord = '';
  List<Word> InputWords = [Word()];
  GameStatus gameStatus = GameStatus.playing;
  int maxAttemps = 6;
  bool checkLine = false, isBackOrEnter = false;

  void Function()? onInvalidWord;

  void Function()? onLost;

  bool gameOver() => (gameStatus == GameStatus.won || gameStatus == GameStatus.lost);

  int correctWordLenght() => _correctWord.length;

  void setCorrectWord({required String word}) {

    if(InputWords.isNotEmpty){
      InputWords = [Word()];
      gameStatus = GameStatus.playing;
    }

    _correctWord = word.toUpperCase();
    if (_correctWord.isNotEmpty) {
      InputWords.last.addLetter(_correctWord[0]);
      notifyListeners();
    }
  }

  setKeyTapped({required String value}) {
    if (value == 'ENT'){
      if (gameStatus == GameStatus.playing &&
          InputWords.last.wordString.length == _correctWord.length) {
        if(validWordsToPlayWith.contains(InputWords.last.wordString)){
          gameStatus = GameStatus.submitting;
          checkWord();
          isBackOrEnter = true;
        }else{
          onInvalidWord?.call();
        }
      }
    } else if (value == 'DEL' ) {
      if (InputWords.last.wordString.length > 1 && gameStatus == GameStatus.playing) {
        InputWords.last.removeLetter();
        isBackOrEnter = true;
      }
    } else {
      if (InputWords.last.wordString.length < _correctWord.length &&
          gameStatus == GameStatus.playing) {
        InputWords.last.addLetter(value);
        isBackOrEnter = false;
      }
    }
    notifyListeners();
  }

  checkWord() {
    String guessWord = InputWords.last.wordString;
    List<String> remainingCorrect = _correctWord.split('');

    if (guessWord == _correctWord) {
      InputWords.last.letters!.asMap().forEach((i, letter) {
        InputWords.last.letters![i] =
            letter.copyWith(status: LetterStatus.correct);
        keyMap.update(letter.val, (value) => LetterStatus.correct);
      });

      gameStatus = GameStatus.won;

    }
    else {
      for (int i = 0; i < guessWord.length; i++) {
        if (guessWord[i] == _correctWord[i]) {
          InputWords.last.letters![i] = InputWords.last.letters![i]
              .copyWith(status: LetterStatus.correct);
          if (keyMap[guessWord[i]] != LetterStatus.correct) {
            keyMap.update(guessWord[i], (value) => LetterStatus.correct);
          }
          remainingCorrect.remove(guessWord[i]);
        }
      }
      for (int i = 0; i < guessWord.length; i++) {
        if (InputWords.last.letters![i].status != LetterStatus.correct) {
          if (remainingCorrect.contains(guessWord[i])) {
            InputWords.last.letters![i] = InputWords.last.letters![i]
                .copyWith(status: LetterStatus.inWord);
            if (keyMap[guessWord[i]] != LetterStatus.correct) {
              keyMap.update(guessWord[i], (value) => LetterStatus.inWord);
            }
            remainingCorrect.remove(guessWord[i]);
          } else {
            InputWords.last.letters![i] = InputWords.last.letters![i]
                .copyWith(status: LetterStatus.notInWord);
            if (keyMap[guessWord[i]] != LetterStatus.correct && keyMap[guessWord[i]] != LetterStatus.inWord) {
              keyMap.update(guessWord[i], (value) => LetterStatus.notInWord);
            }
          }
        }
      }
    }
    if(InputWords.length == maxAttemps && gameStatus != GameStatus.won){
    gameStatus = GameStatus.lost;
    onLost?.call();

    }
    checkLine = true;
    //notifyListeners();
  }

  addNextWord(){
    if (gameStatus == GameStatus.submitting ) {
      InputWords.add(Word());
      InputWords.last.addLetter(_correctWord[0]);
      gameStatus = GameStatus.playing;
    }
  }
}
