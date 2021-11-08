import 'package:flutter/material.dart';
import './constants.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // final list for transactions
  final List<Transaction> transactions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nerit'),
        backgroundColor: Color(mainColor),
      ),
      body: Column(
          // column and rows have main axis (vert and hori) and cross axis
          // these axis position the content where you want it to be inside the col or row
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Card(
                // assumes the size of the child, unless you have it wrapped in a parent
                // text takes only the space needed for the word
                // to change the size of text we need to change the size of the parent Container()
                child:
                    Text('Chart', style: TextStyle(color: Color(0xFFFFFFFF))),
                elevation: 5,
                color: Color(mainColor),
              ),
              width: double.infinity,
            ),
            Container(
              child: Card(
                // assumes the size of the child, unless you have it wrapped in a parent
                // text takes only the space needed for the word
                // to change the size of text we need to change the size of the parent Container()
                child: Text('List of Txn',
                    style: TextStyle(color: Color(0xFFFFFFFF))),
                elevation: 5,
                color: Color(mainColor),
              ),
              width: double.infinity,
            ),
          ]),
    );
  }
}
