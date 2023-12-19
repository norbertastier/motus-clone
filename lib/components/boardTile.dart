import 'package:flutter/material.dart';
import 'package:motus_clone/animations/bounce.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/constants/status.dart';
import 'package:motus_clone/controller.dart';
import 'package:provider/provider.dart';

class BoardTile extends StatefulWidget {
  final Letter letter;
  final int indexRow;
  final int indexColumn;

  const BoardTile({
    Key? key,
    required this.letter,
    required this.indexRow,
    required this.indexColumn,
  }) : super(key: key);

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (_, notifier, __) {
      Letter _letter = Letter.empty();
      bool animate = false;

      if ((notifier.InputWords.length - 1 > widget.indexRow &&
              widget.indexColumn < notifier.correctWordLenght()) ||
          (notifier.InputWords.length - 1 == widget.indexRow &&
              widget.indexColumn < notifier.InputWords.last.letters!.length)) {

        _letter =
        notifier.InputWords[widget.indexRow].letters![widget.indexColumn];

        if (notifier.InputWords.length - 1 == widget.indexRow &&
            widget.indexColumn ==
                notifier.InputWords.last.letters!.length - 1 &&
            !notifier.isBackOrEnter) {
          animate = true;
        }
      } else if ((notifier.InputWords.length - 1 == widget.indexRow &&
          widget.indexColumn >= notifier.InputWords.last.letters!.length)) {
        _letter = Letter(val: '.');
      }

      return Flexible(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
            margin: EdgeInsets.all(0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Bounce(
              animate: animate,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _letter.letterColor,
                  shape: _letter.status == LetterStatus.inWord
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                ),
                child: Text(
                  _letter.val,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
