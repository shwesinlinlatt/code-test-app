import 'package:flutter/material.dart';

void showToast(BuildContext context, String message) {
  final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
