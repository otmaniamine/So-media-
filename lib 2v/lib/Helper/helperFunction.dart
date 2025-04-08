import 'package:flutter/material.dart';

void displayMessageToUser(String message, BuildContext context) {
  //show a snackbar
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        )
        );

}
