import 'package:flutter/material.dart';
import 'package:motus_clone/app/app.dart';
import 'package:motus_clone/controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Controller())],
    child: const App()));
