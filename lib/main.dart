import 'package:flutter/material.dart';
import './home_page.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Despesas Diárias',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber[700],
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
