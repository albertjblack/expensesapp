import 'package:flutter/material.dart';
import '../constants/constants.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                focusNode: new FocusNode(),
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (String _) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (String _) => submitData(),
                // onChanged: (val) {
                //  txnAmountInput = val;
                //},
              ),
              TextButton(
                  child: Text('Add Transaction'),
                  style: TextButton.styleFrom(primary: Color(mainColor)),
                  onPressed: submitData)
            ],
          )),
    );
  }
}
