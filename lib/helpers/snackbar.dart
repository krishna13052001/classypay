import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,
    {String message = "", int seconds = 1}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: seconds)));
}
