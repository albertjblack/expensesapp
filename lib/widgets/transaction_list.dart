import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  TransactionList(this.userTransactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: [
                Text('No transactions yet.',
                    style: Theme.of(context).textTheme.headline6),
                Container(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/ordinary/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ]);
            },
          )
        : ListView.builder(
            itemCount: userTransactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  userTransaction: userTransactions[index],
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}
