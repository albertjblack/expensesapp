import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../constants/constants.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  TransactionList(this.userTransactions);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      height: 205,
      child: ListView.builder(
        itemCount: userTransactions.length,
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 30)),
              Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                      "A: \$${userTransactions[index].amount!.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Color(mainColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(mainColor), width: 2)),
                  margin: EdgeInsets.only(right: 10)),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text((userTransactions[index].title).toString(),
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text(DateFormat('yyyy-MM-dd')
                          .format(userTransactions[index].date!)))
                ],
              ))
            ],
          ));
        },
      ),
      width: double.infinity,
    ));
  }
}
