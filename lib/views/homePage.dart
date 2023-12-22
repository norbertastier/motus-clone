import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motus_clone/app/app.dart';
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
                    height: 50,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Board(
                      numColumns: _word.length,
                      numRows: 6,
                    ),
                  ),
                  Container(
                      height: 60,
                      child: _showInvalidWordMessage
                          ? Center(
                              child: Text(
                                  'Le mot proposé n\'est pas dans la liste !',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          : Container()),
                  KeyBoard(),
                  Spacer(),
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
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // La couleur de l'ombre
                spreadRadius: 0, // L'étendue de l'ombre
                blurRadius: 0, // Le flou de l'ombre
                offset: Offset(0, 5), // La position de l'ombre sur l'axe x,y
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(
              Icons.home_rounded,
              color: background,
            ),
          )),
      onPressed: () {
        keyMap.updateAll(
                (key, value) => value = LetterStatus.initial);


        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const App()),
                (route) => false);

      },
    );
  }
}
