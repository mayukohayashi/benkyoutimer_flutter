import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demoApp',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: "Flutter",
      amount: 3.5,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: "Dart",
      amount: 1,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: "Work out",
      amount: 2,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: "Sleep",
      amount: 2.5,
      date: DateTime.now(),
    )
  ];

  // ここでInput用のStringを用意しておく→onChangeへ
  String titleInput;
  String amountInput;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIME App"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Chart!'),
              color: Colors.blueGrey,
              elevation: 5,
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    // onChanged: (val) => titleInput = val でもおｋ
                    onChanged: (val) {
                      titleInput = val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    onChanged: (val) {
                      amountInput = val;
                    },
                  ),
                  FlatButton(
                    child: Text("Add ALL your time"),
                    textColor: Colors.blue,
                    onPressed: () {
                      print(titleInput);
                      print(amountInput);
                    },
                  )
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((tx) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.pink.shade100,
                        width: 2,
                      )),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${tx.amount} /Hour",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.pink.shade100),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tx.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMEd().add_jms().format(tx.date),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
