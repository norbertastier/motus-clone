import 'package:flutter/material.dart';
import 'package:motus_clone/animations/bounce.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/constants/status.dart';
import 'package:motus_clone/controller.dart';
import 'package:provider/provider.dart';

class BoardTile extends StatefulWidget {
  Letter letter;
  final int indexRow;
  final int indexColumn;

  BoardTile({
    Key? key,
    required this.letter,
    required this.indexRow,
    required this.indexColumn,
  }) : super(key: key);

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    super.initState();
  }

  @override
  void dipose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (_, notifier, __) {
      bool animate = false;

      if (notifier.gameStatus == GameStatus.playing) {
        if (notifier.InputWords.length - 2 == widget.indexRow &&
            notifier.checkLine) {
          Future.delayed(Duration(milliseconds: 300 * widget.indexColumn), () {
            _animationController.notifyListeners();
            Letter _letter = notifier
                .InputWords[widget.indexRow].letters![widget.indexColumn];
            widget.letter = widget.letter
                .copyWith(val: _letter.val, status: _letter.status);
            animate = true;
            notifier.checkLine = false;

            if (widget.indexColumn + 1 ==
                notifier.InputWords[widget.indexRow].letters!.length) {
              notifier.notifyListeners();
            }
          });
        } else if (((notifier.InputWords.length - 1 > widget.indexRow &&
                    widget.indexColumn < notifier.correctWordLenght()) ||
                (notifier.InputWords.length - 1 == widget.indexRow &&
                    widget.indexColumn <
                        notifier.InputWords.last.letters!.length)) &&
            !notifier.checkLine) {
          Letter _letter =
              notifier.InputWords[widget.indexRow].letters![widget.indexColumn];
          widget.letter =
              widget.letter.copyWith(val: _letter.val, status: _letter.status);

          if (notifier.InputWords.length - 1 == widget.indexRow &&
              widget.indexColumn ==
                  notifier.InputWords.last.letters!.length - 1 &&
              !notifier.isBackOrEnter) {
            if(widget.indexColumn != 0){
              animate = true;
            }
          }
        } else if (((notifier.InputWords.length - 1 == widget.indexRow &&
                widget.indexColumn >=
                    notifier.InputWords.last.letters!.length)) &&
            !notifier.checkLine) {
          Letter _letter = Letter(val: '.');
          widget.letter =
              widget.letter.copyWith(val: _letter.val, status: _letter.status);
        }
      } else if (notifier.gameStatus == GameStatus.won &&
          notifier.InputWords.length - 1 == widget.indexRow) {
        Future.delayed(Duration(milliseconds: 300 * widget.indexColumn), () {
          _animationController.notifyListeners();
          Letter _letter =
              notifier.InputWords[widget.indexRow].letters![widget.indexColumn];
          widget.letter =
              widget.letter.copyWith(val: _letter.val, status: _letter.status);
          animate = true;
          notifier.checkLine = false;
        });
      }else if (notifier.gameStatus == GameStatus.lost &&
          notifier.InputWords.length - 1 == widget.indexRow){Future.delayed(Duration(milliseconds: 300 * widget.indexColumn), () {
        _animationController.notifyListeners();
        Letter _letter =
        notifier.InputWords[widget.indexRow].letters![widget.indexColumn];
        widget.letter =
            widget.letter.copyWith(val: _letter.val, status: _letter.status);
        animate = true;
        notifier.checkLine = false;
      });}

      return Flexible(
        child: FittedBox(
          fit: BoxFit.contain,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (_, child) {
                return Container(
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
                        color: widget.letter.letterColor,
                        shape: widget.letter.status == LetterStatus.inWord
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                      ),
                      child: Text(
                        widget.letter.val,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
