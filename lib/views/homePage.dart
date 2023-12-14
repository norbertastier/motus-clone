import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motus_clone/constants/colors.dart';
import 'package:motus_clone/controller.dart';
import 'package:motus_clone/data/dictionary.dart';
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
  late String _word;

  @override

  void initState(){
    _word = words[Random().nextInt(words.length)];
    print(_word);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
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
                Container(height: 50,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Board(
                    numColumns: _word.length,
                    numRows: 6,
                  ),
                ),
                Container(height: 60,),
                KeyBoard(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
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
        // Handle home button press
      },
    );
  }
}
