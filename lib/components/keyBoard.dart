import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/constants/colors.dart';
import 'package:motus_clone/constants/keys.dart';
import 'package:motus_clone/constants/status.dart';
import 'package:motus_clone/controller.dart';
import 'package:motus_clone/data/keyStatus.dart';
import 'package:provider/provider.dart';

final double vertical_padding = 3.0;
final double horizontal_padding = 2.0;
const double maxWidth = 38;
const double maxHeight = 54;
final icon = null;

class KeyBoard extends StatelessWidget {
  const KeyBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double w_;

    maxWidth <= (screenSize.width / 10) - 2 * horizontal_padding
        ? w_ = maxWidth
        : w_ = (screenSize.width / 10) - 2 * horizontal_padding;

    return Consumer<Controller>(builder: (_, notifier, __) {
      return IgnorePointer(
        ignoring: notifier.gameOver(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: azerty
              .map(
                (keyRow) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: keyRow.map((letter) {
                    LetterStatus? _status;
                    Color? _backgroundKeyColor;
                    Color? _borderKeyColor;
                    List<Color> _gradientColors;

                    _status = keyMap[letter];

                    switch (_status) {
                      case LetterStatus.correct:
                        _backgroundKeyColor = correctColorKey;
                        _borderKeyColor = backgroundTop;
                        _gradientColors = gradientCorrectColorKey;
                      case LetterStatus.inWord:
                        _backgroundKeyColor = inWordColorKey;
                        _borderKeyColor = backgroundTop;
                        _gradientColors = gradientInWordColorKey;
                      case LetterStatus.notInWord:
                        _backgroundKeyColor = Colors.transparent;
                        _borderKeyColor = notInWordColorKey;
                        _gradientColors = gradientNotInWordColorkey;
                      default:
                        _backgroundKeyColor = Colors.transparent;
                        _borderKeyColor = backgroundTop;
                        _gradientColors = gradientKeyColor;
                    }

                    switch (letter) {
                      case 'ENT':
                        return Flexible(
                          fit: FlexFit.tight,
                          child: _KeyboardButton(
                            letter: letter,
                            gradient: _gradientColors,
                            icon: Icons.exit_to_app,
                            maxWidth_: w_ * 1.5,
                            borderColor: Colors.transparent,
                          ),
                        );
                      case 'DEL':
                        return Flexible(
                          fit: FlexFit.tight,
                          child: _KeyboardButton(
                            letter: letter,
                            gradient: _gradientColors,
                            icon: Icons.backspace,
                            maxWidth_: w_ * 1.5,
                            borderColor: Colors.transparent,
                          ),
                        );
                      default:
                        return _KeyboardButton(
                          letter: letter,
                          backgroundColor: _backgroundKeyColor,
                          maxWidth_: w_,
                          borderColor: _borderKeyColor,
                          gradient: _gradientColors,
                        );
                    }
                  }).toList(),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}

class _KeyboardButton extends StatelessWidget {
  final String letter;
  final IconData? icon;
  final double maxWidth_;
  final double maxHeight_;
  final Color borderColor;
  final Color backgroundColor;
  final List<Color>? gradient;

  const _KeyboardButton({
    Key? key,
    required String this.letter,
    this.icon,
    this.maxHeight_ = maxHeight,
    this.maxWidth_ = maxWidth,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth_, maxHeight: maxHeight_),
      margin: EdgeInsets.symmetric(
          horizontal: horizontal_padding, vertical: vertical_padding),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Provider.of<Controller>(context, listen: false)
                .setKeyTapped(value: letter);
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Transform(
              transform: Matrix4.identity()..rotateX(-0.5),
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient != null
                        ? gradient!
                        : [Colors.transparent, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow:
                  gradient != null && gradient!.last != Colors.transparent
                      ? [
                    BoxShadow(
                        color: gradient!.last
                            .withOpacity(1),
                        offset: Offset(0, 7)),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 7)),
                  ]
                      : null,
                ),
                width: maxWidth_,
                height: maxHeight_,
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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

                  child: icon != null
                      ? FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        icon,
                        color: backgroundTop,
                        size: maxWidth_,
                      ),
                    ),
                  )
                      : FittedBox(
                    child: Text(
                      letter!,
                      style: TextStyle(
                        color: borderColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
