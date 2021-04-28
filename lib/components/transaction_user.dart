import 'package:flutter/material.dart';
import './transaction_form.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transaction = [
    Transaction(
      id: 'id',
      title: 'title',
      value: 220.20,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'id2',
      title: 'title2',
      value: 440.00,
      date: DateTime.now().add(Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(_transaction),
        TransactionForm(),
      ],
    );
  }
}
