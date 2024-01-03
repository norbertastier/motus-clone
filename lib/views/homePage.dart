import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motus_clone/app/app.dart';
import 'package:motus_clone/components/message.dart';
import 'package:motus_clone/constants/colors.dart';
import 'package:motus_clone/constants/status.dart';
import 'package:motus_clone/controller.dart';
import 'package:motus_clone/data/keyStatus.dart';
import 'package:motus_clone/data/wordsForTheDraw.dart';
import 'package:provider/provider.dart';

import '../components/board.dart';
import '../components/keyBoard.dart';
import '../components/titleLogo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _minLetter = 5;
  int _maxLetter = 9;

  late String _word;
  bool _showInvalidWordMessage = false;
  bool _lostShowTheWord = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    do {
      _word = wordsForTheDraw[Random().nextInt(wordsForTheDraw.length)];
    } while (!(_minLetter <= _word.length && _word.length <= _maxLetter));

    print(_word);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: _word);
      Provider.of<Controller>(context, listen: false).onInvalidWord =
          showInvalidWordMessage;
      Provider.of<Controller>(context, listen: false).onLost = lostShowTheWord;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (event) {
        _KeyDownEvent(event);
      },
      child: Container(
        color: background,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 430),
            child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                titleSpacing: 0,
                leading: HomeButton(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleLogo(),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 32),
                    margin: EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.5, 1],
                          colors: gradientBackgroundTop),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: Offset(0, 24),
                        ),
                        BoxShadow(
                          color: gradientBackgroundTop.last.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(0, 16),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(0, 16),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 156,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Board(
                            numColumns: _word.length,
                            numRows: 6,
                          ),
                        ),
                        !_lostShowTheWord
                            ? Message(
                                show: _showInvalidWordMessage,
                                message:
                                    'Le mot proposé n\'est pas dans la liste !')
                            : Message(
                                show: _lostShowTheWord,
                                message: 'Le mot était : ${_word}'),
                      ],
                    ),
                  ),
                  Expanded(child: Container(child: KeyBoard())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showInvalidWordMessage() {
    setState(() => _showInvalidWordMessage = true);

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showInvalidWordMessage = false);
      }
    });
  }

  void lostShowTheWord() {
    setState(() => _lostShowTheWord = true);
  }

  void _KeyDownEvent(event) {
    if (event is RawKeyDownEvent) {
      final Controller controller =
          Provider.of<Controller>(context, listen: false);
      String value = '';
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        value = 'ENT';
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        value = 'DEL';
      } else if (event.logicalKey == LogicalKeyboardKey.period) {
        value = event.logicalKey.keyLabel;
      } else if (event.logicalKey.keyLabel.isNotEmpty &&
          event.logicalKey.keyLabel.length == 1 &&
          event.logicalKey.keyLabel.contains(RegExp(r'[A-Z]'))) {
        value = event.logicalKey.keyLabel;
      }

      if (value.isNotEmpty) {
        controller.setKeyTapped(value: value);
      }
    }
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
          width: 40,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: background,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(
              Icons.home_rounded,
              color: backgroundTop,
            ),
          )),
      onPressed: () {
        keyMap.updateAll((key, value) => value = LetterStatus.initial);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const App()),
            (route) => false);
      },
    );
  }
}
