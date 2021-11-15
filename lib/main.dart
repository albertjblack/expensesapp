import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './constants/constants.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtus',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // final list for transactions
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [];

  void _addNewTransaction(String txnTitle, double txnAmount) {
    final newTxn = Transaction(
        title: txnTitle,
        amount: txnAmount,
        date: DateTime.now(),
        id: "${txnTitle}-${txnAmount}-${DateTime.now()}");
    setState(() {
      userTransactions.add(newTxn);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: NewTransaction(_addNewTransaction),
              onTap:
                  () {}, // if user clicks on sheet nothing will happen (it will not close)
              behavior: HitTestBehavior
                  .opaque); // catch events and avoids that a tap on the gesture detector triggers
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () => startAddNewTransaction(context),
              icon: Icon(Icons.add),
            )
          ],
          title: Image(
            image: myLogoPng,
            width: 64,
          ),
          backgroundColor: Color(mainColor),
        ),
        body: SingleChildScrollView(
          child: Column(
              // column and rows have main axis (vert and hori) and cross axis
              // these axis position the content where you want it to be inside the col or row
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Card(
                    // assumes the size of the child, unless you have it wrapped in a parent
                    // text takes only the space needed for the word
                    // to change the size of text we need to change the size of the parent Container()
                    child: Text('Chart', style: TextStyle(color: Colors.white)),
                    elevation: 5,
                    color: Color(mainColor),
                  ),
                  width: double.maxFinite,
                ),
                TransactionList(userTransactions)
              ]),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
            backgroundColor: Color(mainColor)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
