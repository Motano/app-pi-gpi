import 'package:aplicacionpi/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'themes/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traductor',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => Home()},
      theme: MainTheme.theme,
    );
  }
}
