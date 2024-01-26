import 'package:flutter/material.dart';

Center customSubmitButton(String buttonText, void Function()? onSubmit) {
  return Center(
    child: ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(color: Colors.red)))),
      onPressed: onSubmit,
      child: Text(buttonText, style: const TextStyle(fontSize: 14)),
    ),
  );
}
