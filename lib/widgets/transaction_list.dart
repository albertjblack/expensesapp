import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  TransactionList(this.userTransactions, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: userTransactions.isEmpty
          ? Column(children: [
              Text('No transactions yet.',
                  style: Theme.of(context).textTheme.headline6),
              Container(
                  height: 100,
                  child: Image.asset(
                    'assets/images/ordinary/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ])
          : ListView.builder(
              itemCount: userTransactions.length,
              itemBuilder: (ctx, index) {
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
                                  "\$${userTransactions[index].amount}",
                                  textAlign: TextAlign.start,
                                )),
                              ),
                            )),
                      ),
                      title: Text("${userTransactions[index].title}",
                          style: Theme.of(context).textTheme.headline6),
                      subtitle: Text(
                          '${DateFormat.yMMMd().format(userTransactions[index].date!)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            deleteTransaction(userTransactions[index].id),
                        color: Theme.of(context).errorColor,
                      )),
                );
              },
            ),
      width: double.infinity,
    );
  }
}
