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

                    _status = keyMap[letter];

                    switch (_status) {
                      case LetterStatus.correct:
                        _backgroundKeyColor = correctColorKey;
                        _borderKeyColor = Colors.white;
                      case LetterStatus.inWord:
                        _backgroundKeyColor = inWordColorKey;
                        _borderKeyColor = Colors.white;
                      case LetterStatus.notInWord:
                        _backgroundKeyColor = Colors.transparent;
                        _borderKeyColor = notInWordColorKey;
                      default:
                        _backgroundKeyColor = Colors.transparent;
                        _borderKeyColor = Colors.white;
                    }

                    switch (letter) {
                      case 'ENT':
                        return Flexible(
                          fit: FlexFit.tight,
                          child: _KeyboardButton(
                            letter: letter,
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

  const _KeyboardButton({
    Key? key,
    required String this.letter,
    this.icon,
    this.maxHeight_ = maxHeight,
    this.maxWidth_ = maxWidth,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.transparent,
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
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: borderColor, width: 2),
            ),
            width: maxWidth_,
            height: maxHeight_,
            alignment: Alignment.center,
            child: icon != null
                ? FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                        icon,
                        color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}
