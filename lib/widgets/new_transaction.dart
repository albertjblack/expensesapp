import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('Constructor NewTransaction Widget');
  }

  @override
  _NewTransactionState createState() {
    print('createState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget() _NewTransactionState');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    print('initState() _NewTransactionState Widget');
    super.initState();
  }

  @override
  void dispose() {
    print('dispose() _NewTransactionState');
    super.dispose();
  }

  _NewTransactionState() {
    print('Constructor NewTransactionState');
  }

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
    return SingleChildScrollView(
      child: Card(
        child: Container(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: 'Title',
                        controller: titleController,
                        onSubmitted: (String _) => submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: titleController,
                        onSubmitted: (String _) => submitData(),
                      ),
                Platform.isIOS
                    ? CupertinoTextField(
                        placeholder: 'Amount',
                        controller: amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onSubmitted: (String _) => submitData(),
                      )
                    : TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        controller: amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
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
                      Platform.isIOS
                          ? CupertinoButton(
                              child: Text(
                                _selectedDate == null
                                    ? 'Choose date'
                                    : "Change date",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: _presentDatePicker)
                          : TextButton(
                              child: Text(
                                _selectedDate == null
                                    ? 'Choose date'
                                    : "Change date",
                              ),
                              onPressed: _presentDatePicker,
                              style: TextButton.styleFrom(
                                  primary: Color(mainColor)),
                            ),
                    ],
                  ),
                ),
                Platform.isIOS
                    ? SizedBox(
                        child: CupertinoButton(
                            child: Text('Add'),
                            onPressed: submitData,
                            color: Theme.of(context).primaryColor),
                      )
                    : ElevatedButton(
                        child: Text('Add transaction'),
                        style: TextButton.styleFrom(
                            primary: Theme.of(context).textTheme.button!.color,
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: submitData),
              ],
            )),
      ),
    );
  }
}
