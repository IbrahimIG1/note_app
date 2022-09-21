import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:nota/shared/bloc_observer.dart';
import 'modules/home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme : ThemeData
      // (
      //   appBarTheme: const AppBarTheme
      //   (
      //     backgroundColor:Colors.amber )
      // ),
      home: MyHome(),
    );
  }
}
