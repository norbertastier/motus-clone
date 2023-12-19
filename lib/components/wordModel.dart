import 'package:equatable/equatable.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/constants/status.dart';

class Word extends Equatable {
  final List<Letter>? letters;

  Word({List<Letter>? letters}) : this.letters = letters ?? [];

  factory Word.fromString(String word) =>
      Word(letters: word.split('').map((e) => Letter(val: e)).toList());

  String get wordString => letters!.map((e)=>e.val).join();

  void addLetter(String val){
      letters!.add(Letter(val: val, status: LetterStatus.typing));
  }

  void removeLetter(){
    if (letters!.isNotEmpty){
      letters!.removeLast();
    }
  }

  void clear(){
    letters!.clear();
  }

  @override
  List<Object?> get props => [letters];
}
