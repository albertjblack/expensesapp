import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 3,
      child: ListTile(
          leading: Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: FittedBox(
                        child: Text(
                      "\$${userTransaction.amount}",
                      textAlign: TextAlign.start,
                    )),
                  ),
                )),
          ),
          title: Text("${userTransaction.title}",
              style: Theme.of(context).textTheme.headline6),
          subtitle: Text('${DateFormat.yMMMd().format(userTransaction.date!)}'),
          trailing: MediaQuery.of(context).size.width > 360
              ? TextButton.icon(
                  icon: Platform.isIOS
                      ? Icon(CupertinoIcons.delete)
                      : Icon(Icons.delete),
                  label: Text('Delete'),
                  onPressed: () => deleteTransaction(userTransaction.id),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).errorColor))
              : IconButton(
                  icon: Platform.isIOS
                      ? Icon(CupertinoIcons.delete)
                      : Icon(Icons.delete),
                  onPressed: () => deleteTransaction(userTransaction.id),
                  color: Theme.of(context).errorColor,
                )),
    );
  }
}
