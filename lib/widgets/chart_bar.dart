import '../constants/constants.dart';
import './chart.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 20,
          child:
              FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
      SizedBox(height: 4),
      Container(
          height: 50,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(secondaryColor),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: spendingPercent,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor)),
                ),
              ),
            ],
          )),
      SizedBox(height: 4),
      Text(label)
    ]);
  }
}
