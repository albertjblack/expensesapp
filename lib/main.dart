import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> userTransactions = [];
  var _switchChoice = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

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

  Widget _buildCupertinoAppBar() {
    return CupertinoNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      middle: Image(
        image: myLogoPng,
        width: 64,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () => startAddNewTransaction(context),
              child: Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
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
    );
  }

  List<Widget> _buildLPortraitContent(
      appBar, MediaQueryData mediaQuery, Widget TxnList) {
    return [
      Container(
        // assumes the size of the child, unless you have it wrapped in a parent
        // text takes only the space needed for the word
        // to change the size of text we need to change the size of the parent Container()
        child: Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.2,
            child: Chart(recentTransactions)),
        //color: Theme.of(context).primaryColor, ///// CHART CHART CHART
      ),
      TxnList
    ];
  }

  List<Widget> _buildLandscapeContent(appBar, Widget TxnList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Chart', style: Theme.of(context).textTheme.headline6),
          Switch.adaptive(
              value: _switchChoice,
              onChanged: (val) {
                setState(() {
                  _switchChoice = val;
                });
              },
              activeColor: Color(mainColor))
        ],
      ),
      _switchChoice
          ? Container(
              // assumes the size of the child, unless you have it wrapped in a parent
              // text takes only the space needed for the word
              // to change the size of text we need to change the size of the parent Container()
              child: Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.7,
                  child: Chart(recentTransactions)),
              //color: Theme.of(context).primaryColor, ///// CHART CHART CHART
            )
          : TxnList
    ];
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
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = (Platform.isIOS
        ? _buildCupertinoAppBar() //
        : _buildAppBar()) as PreferredSizeWidget;

    final TxnList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionList(userTransactions, _deleteTransaction));
    final appBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
          // column and rows have main axis (vert and hori) and cross axis
          // these axis position the content where you want it to be inside the col or row
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  if (!isLandscape)
                    ..._buildLPortraitContent(appBar, mediaQuery, TxnList),
                  if (isLandscape) ..._buildLandscapeContent(appBar, TxnList),
                ],
              ),
              width: double.maxFinite,
            ),
          ]),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => startAddNewTransaction(context),
                    backgroundColor: Theme.of(context).secondaryHeaderColor),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat);
  }
}
