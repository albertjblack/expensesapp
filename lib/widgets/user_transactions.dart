import 'package:flutter/widgets.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  UserTransactionsState createState() => UserTransactionsState();
}

class UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(userTransactions, () {})
      ],
    );
  }
}
