import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './constants/constants.dart';
import './models/transaction.dart';
import './constants/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Virtus',
      theme: ThemeData(
          /*    colorScheme:
            theme.colorScheme.copyWith(secondary: Color(secondaryColor)), */
          primaryColor: generateMaterialColor(Color(mainColor)),
          secondaryHeaderColor: Color(secondaryColor),
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(fontFamily: ''),
              button: TextStyle(
                color: Colors.white,
              ))),
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

  void _addNewTransaction(
      String txnTitle, double txnAmount, DateTime chosenDate) {
    final newTxn = Transaction(
        title: txnTitle,
        amount: txnAmount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      userTransactions.add(newTxn);
      userTransactions.sort((a, b) => b.date!.compareTo(a.date!));
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

  void _deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((txn) => txn.id == id);
    });
  }

  List<Transaction> get recentTransactions {
    // where returns an iterable just as map() so we use .tolist
    return userTransactions.where((txn) {
      // will return true or false if condition is after is met. and if true that element will be on recentTransactions
      return txn.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
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
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
              // column and rows have main axis (vert and hori) and cross axis
              // these axis position the content where you want it to be inside the col or row
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // assumes the size of the child, unless you have it wrapped in a parent
                        // text takes only the space needed for the word
                        // to change the size of text we need to change the size of the parent Container()
                        child: Chart(recentTransactions),
                        //color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  width: double.maxFinite,
                ),
                TransactionList(userTransactions, _deleteTransaction)
              ]),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context),
            backgroundColor: Theme.of(context).secondaryHeaderColor),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
