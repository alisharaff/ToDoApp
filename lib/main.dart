import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/shared/cubit/observer.dart';
import 'package:to_do_list/test.dart';

import 'homescreen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  // Use cubits...
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.teal
      ),
      home:homeScreen(),
    );
  }
}

