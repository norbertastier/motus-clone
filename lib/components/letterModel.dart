import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/constants/colors.dart';

import '../constants/status.dart';

class Letter extends Equatable {
  final String val;
  final LetterStatus status;

  const Letter({required this.val, this.status = LetterStatus.initial});

  factory Letter.empty() => const Letter(val: '');
  factory Letter.dot() => const Letter(val: '.');

  Color get letterColor {
    switch (status) {
      case LetterStatus.initial:
        return initialColor;
      case LetterStatus.typing:
        return typingColor;
      case LetterStatus.notInWord:
        return notInWordColor;
      case LetterStatus.inWord:
        return inWordColor;
      case LetterStatus.correct:
        return correctColor;
    }
  }

  List<Color> get gradientColor {
    switch (status) {
      case LetterStatus.initial:
        return gradientInitial;
      case LetterStatus.typing:
        return gradientTypingColor;
      case LetterStatus.notInWord:
        return gradientNotInWordColor;
      case LetterStatus.inWord:
        return gradientInWordColor;
      case LetterStatus.correct:
        return gradientCorrectColor;
    }
  }

  Letter copyWith({
    String? val,
    LetterStatus? status,
  }) {
    return Letter(
      val: val ?? this.val,
      status: status ?? this.status,
    );
  }


  @override
  List<Object?> get props => [val, status];
}
