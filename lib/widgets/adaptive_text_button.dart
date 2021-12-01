import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final String text2;
  final _dateTime = null;
  final Function handler;

  AdaptiveTextButton(this.text, this.text2, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _dateTime == null ? text : text2,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: handler())
        : TextButton(
            child: Text(
              _dateTime == null ? text : text2,
            ),
            onPressed: handler(),
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          );
  }
}
