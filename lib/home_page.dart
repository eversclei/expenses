import 'dart:math';

import 'package:flutter/material.dart';

import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './models/transaction.dart';
import './components/chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (tr) {
        return tr.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  _addTransaction(String titleParam, double valueParam, DateTime date) {
    // for (var j = 0; j < 3; j++) {
    //   for (var i = 0; i < 7; i++) {
    //     final newTransaction = Transaction(
    //       id: Random().nextDouble().toString(),
    //       title: titleParam + "." + i.toString(),
    //       value: valueParam * (i + 1),
    //       date: date.add(Duration(days: (i * -1))),
    //     );

    //     setState(() {
    //       _transactions.add(newTransaction);
    //     });
    //   }
    // }
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: titleParam,
      value: valueParam,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Despesas Diárias'),
      actions: <Widget>[
        if (_isLandScape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !_isLandScape)
              Container(
                height: availableHeight * (!_isLandScape ? 0.3 : 0.7),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !_isLandScape)
              Container(
                height: availableHeight * (!_isLandScape ? 0.7 : 1),
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
    );
  }
}
