import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  // method to dynamically generate the bars (a getter which is a dynamically generated property)
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      // getting the weekday dynamically generated based on index and substractions
      final weekDay = DateTime.now().subtract(Duration(
        days: index,
      ));
      // for loop to get all the transactions that were created in the day
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date!.day == weekDay.day &&
            recentTransaction[i].date!.month == weekDay.month &&
            recentTransaction[i].date!.year == weekDay.year) {
          totalSum += (recentTransaction[i].amount!).toDouble();
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList(); // length, generator function
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, txn) {
      return sum +
          double.parse(txn['amount']
              .toString()); // this will retunr a new value as an input to the function for the next element in line -> recursion
    }); // starting value, func -> return list to a number value
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactionValues.map((data) {
                // wrapped with flexible widget to make sure size does not change
                return Flexible(
                  fit: FlexFit
                      .tight, // force size to use maximum space and will be the same for all
                  child: ChartBar(
                      data['day'].toString(),
                      double.parse(data['amount'].toString()),
                      totalSpending == 0
                          ? 0
                          : (double.parse(data['amount'].toString()) /
                              totalSpending)),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
