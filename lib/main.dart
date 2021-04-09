import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BENKYOU TIMER App'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Text('Chart!'),
          ),
          Card(
            child: Text("List of TX"),
          ),
        ],
      ),
    );
  }
}
