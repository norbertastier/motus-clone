import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/components/boardTile.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/components/wordModel.dart';

class Board extends StatelessWidget {
  final int numRows;
  final int numColumns;

  const Board({
    Key? key,
    required this.numRows,
    required this.numColumns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Word> _board = List.generate(numRows,
        (_) => Word(letters: List.generate(numColumns, (_) => Letter.empty())));

    //print(_board);

    return Column(
      children: _board
          .asMap()
          .map(
            (i, word) => MapEntry(
              i,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: word.letters!
                    .asMap()
                    .map(
                      (j, letter) => MapEntry(
                          j,
                          BoardTile(
                            letter: Letter.empty(),
                            indexRow: i,
                            indexColumn: j,
                          )),
                    )
                    .values
                    .toList(),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
