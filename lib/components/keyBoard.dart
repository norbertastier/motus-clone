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
    return Consumer<Controller>(builder: (_, notifier, __) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: azerty
            .map(
              (keyRow) => Container(
                child: Row(
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
                        return _KeyboardButton(
                          letter: letter,
                          icon: Icons.exit_to_app,
                          maxWidth_: 80,
                          borderColor: Colors.transparent,
                        );
                      case 'DEL':
                        return _KeyboardButton(
                          letter: letter,
                          icon: Icons.backspace,
                          maxWidth_: 80,
                          borderColor: Colors.transparent,
                        );
                      default:
                        return _KeyboardButton(
                          letter: letter,
                          backgroundColor: _backgroundKeyColor,
                          borderColor: _borderKeyColor,
                        );
                    }
                  }).toList(),
                ),
              ),
            )
            .toList(),
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
    return Flexible(
      fit: icon != null ? FlexFit.tight : FlexFit.loose,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical_padding,
          horizontal: horizontal_padding,
        ),
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
                  ? Container(
                      width: maxWidth_,
                      height: maxHeight_,
                      child: FittedBox(
                        child: Icon(
                          icon,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : FittedBox(
                      fit: BoxFit.cover,
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
      ),
    );
  }
}
