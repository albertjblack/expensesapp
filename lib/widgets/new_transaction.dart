import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(titleController.text, double.parse(amountController.text),
        _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light().copyWith(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
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
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'No date chosen'
                        : "${DateFormat.yMd().format(_selectedDate!)}"),
                    TextButton(
                      child: Text(
                        _selectedDate == null ? 'Choose date' : "Change date",
                      ),
                      onPressed: _presentDatePicker,
                      style: TextButton.styleFrom(primary: Color(mainColor)),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  child: Text('Add transaction'),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).textTheme.button!.color,
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: submitData),
            ],
          )),
    );
  }
}
