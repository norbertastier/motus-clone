import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/components/boardTile.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/components/wordModel.dart';
import 'package:motus_clone/constants/colors.dart';

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

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
      ),
      //margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _board
            .asMap()
            .map(
              (i, word) => MapEntry(
                i,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
