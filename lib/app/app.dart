import 'package:flutter/material.dart';
import 'package:motus_clone/constants/colors.dart';
import 'package:motus_clone/views/homePage.dart';

class App extends StatelessWidget{
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Motus App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: background),
      home: const HomePage(),
    );
  }
}