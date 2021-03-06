import 'dart:async';
import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';


void main()  {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APPPPPPPPP',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.green[300],
          errorColor: Colors.red[200],
          fontFamily: "Quicksand",
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        "TIME",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home_outlined),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

  // Future main() async {
  //   List timeEntries;
  //   var db = new DatabaseHelper();

  //   await db.saveTime(new TimeEntry(001, DateTime.now(), 3.5, "test0"));
  //   await db.saveTime(new TimeEntry(002, DateTime.now(), 1.5, "test1"));
  //   await db.saveTime(new TimeEntry(003, DateTime.now(), 5.5, "test2"));

  //   print('=== getAllTimeEntry() ===');
  //   timeEntries = await db.getAllTimes();
  //   timeEntries.forEach((timeEntry) => print(timeEntry));

  //   int count = await db.getCount();
  //   print('Count: $count');

  //   print('=== getTimeEntry(2) ===');
  //   TimeEntry timeEntry = await db.getTime(2);
  //   print(timeEntry.toMap());

  //   print('=== updateNote[id:003] ===');
  //   TimeEntry updatedTime = TimeEntry.fromMap({
  //     'TimeEntryId': 003,
  //     'TimeEntryDate': DateTime.now(),
  //     'TimeEntrySpan': 3.7,
  //     'TimeEntryTitle': 'testttttt'
  //   });
  //   await db.updateTime(updatedTime);

  //   timeEntries = await db.getAllTimes();
  //   timeEntries.forEach((timeEntry) => print(timeEntry));

  //   print('=== deleteNote(2) ===');
  //   await db.deleteTime(002);
  //   timeEntries = await db.getAllTimes();
  //   timeEntries.forEach((timeEntry) => print(timeEntry));

  //   await db.close();
  // }

