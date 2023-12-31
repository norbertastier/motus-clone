import 'package:flutter/material.dart';
import 'package:motus_clone/animations/bounce.dart';
import 'package:motus_clone/components/letterModel.dart';
import 'package:motus_clone/constants/colors.dart';
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
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool shouldUpdateForCheckLine(Controller notifier) {
    return notifier.InputWords.length - 1 == widget.indexRow &&
        notifier.checkLine;
  }

  void animateAndUpdateForCheckLine(Controller notifier) {
    Future.delayed(Duration(milliseconds: 300 * widget.indexColumn), () {
      if (mounted) {
        _animationController.notifyListeners();

        updateLetter(notifier);
        notifier.checkLine = false;
        if (isLastLetterInRow(notifier)) {
          notifier.addNextWord();
          notifier.notifyListeners();
        }
      }
    });
  }

  bool shouldUpdateForNextInput(Controller notifier) {
    return (notifier.InputWords.length - 1 > widget.indexRow &&
            widget.indexColumn < notifier.correctWordLenght()) ||
        (notifier.InputWords.length - 1 == widget.indexRow &&
                widget.indexColumn <
                    notifier.InputWords.last.letters!.length) &&
            !notifier.checkLine;
  }

  bool updateForNextInput(Controller notifier) {
    updateLetter(notifier);
    return notifier.InputWords.length - 1 == widget.indexRow &&
        widget.indexColumn == notifier.InputWords.last.letters!.length - 1 &&
        !notifier.isBackOrEnter &&
        widget.indexColumn != 0;
  }

  bool shouldClearForNoInput(Controller notifier) {
    return notifier.InputWords.length - 1 == widget.indexRow &&
        widget.indexColumn >= notifier.InputWords.last.letters!.length &&
        !notifier.checkLine;
  }

  void clearForNoInput() {
    widget.letter =
        widget.letter.copyWith(val: '.', status: LetterStatus.initial);
  }

  bool isLastLetterInRow(Controller notifier) {
    return widget.indexColumn + 1 ==
        notifier.InputWords[widget.indexRow].letters!.length;
  }

  void updateLetter(Controller notifier) {
    Letter _letter =
        notifier.InputWords[widget.indexRow].letters![widget.indexColumn];
    widget.letter =
        widget.letter.copyWith(val: _letter.val, status: _letter.status);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(builder: (_, notifier, __) {
      bool animate = false;
      if (shouldUpdateForCheckLine(notifier)) {
        animateAndUpdateForCheckLine(notifier);
      } else if (shouldUpdateForNextInput(notifier)) {
        animate = updateForNextInput(notifier);
      } else if (shouldClearForNoInput(notifier)) {
        clearForNoInput();
      }

      // Build the widget
      return buildTile(animate);
    });
  }

  Widget buildTile(bool animate) {
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
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Bounce(
                animate: animate,
                child: Transform(
                  transform: Matrix4.identity()..rotateX(-0.5),
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                          colors: widget.letter.gradientColor,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      //color: widget.letter.letterColor,
                      shape: BoxShape.rectangle,
                      boxShadow:
                          widget.letter.gradientColor.last != Colors.transparent
                              ? [
                                  BoxShadow(
                                      color: widget.letter.gradientColor.last
                                          .withOpacity(1),
                                      offset: Offset(0, 7)),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      offset: Offset(0, 7)),
                                ]
                              : null,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
                              stops: [
                                0.0,
                                0.1
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Text(
                        widget.letter.val,
                        style: const TextStyle(
                            color: background,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
