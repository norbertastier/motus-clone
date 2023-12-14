import 'package:flutter/material.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/components/wordModel.dart';
import 'package:motus_clone/constants/status.dart';
import 'package:motus_clone/data/keyStatus.dart';

class Controller extends ChangeNotifier {
  String _correctWord = '';
  List<Word> InputWords = [Word()];
  GameStatus _gameStatus = GameStatus.playing;
  int maxAttemps = 6;

  int correctWordLenght() => _correctWord.length;

  void setCorrectWord({required String word}) {
    _correctWord = word.toUpperCase();
    if (_correctWord.isNotEmpty) {
      InputWords.last.addLetter(_correctWord[0]);
      notifyListeners();
    }
  }

  setKeyTapped({required String value}) {
    if (value == 'ENT'){
      if (_gameStatus == GameStatus.playing &&
          InputWords.last.wordString.length == _correctWord.length) {
        _gameStatus = GameStatus.submitting;
        checkWord();
      }
    } else if (value == 'DEL' ) {
      if (InputWords.last.wordString.length > 1 && _gameStatus == GameStatus.playing) {
        InputWords.last.removeLetter();
      }
    } else {
      if (InputWords.last.wordString.length < _correctWord.length &&
          _gameStatus == GameStatus.playing) {
        InputWords.last.addLetter(value);
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

      _gameStatus = GameStatus.won;

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
            if (keyMap[guessWord[i]] != LetterStatus.correct) {
              keyMap.update(guessWord[i], (value) => LetterStatus.notInWord);
            }
          }
        }
      }
    }
    if(InputWords.length == maxAttemps && _gameStatus != GameStatus.won){
    _gameStatus = GameStatus.lost;
    }
    else{
      if (_gameStatus == GameStatus.submitting ) {
        InputWords.add(Word());
        InputWords.last.addLetter(_correctWord[0]);
        _gameStatus = GameStatus.playing;
      }
      
    }
    print(_gameStatus);
    notifyListeners();
  }
}
