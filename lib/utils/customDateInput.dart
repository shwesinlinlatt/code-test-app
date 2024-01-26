import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:union/utils/custom_text.dart';

Container customDateInput(TextEditingController dateController,
    String labelText, BuildContext context) {
  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: TextFormField(
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
          labelText: CustomText.getText(context, labelText),
          labelStyle: const TextStyle(fontSize: 14, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: IconButton(
              onPressed: pickDate,
              icon: const Icon(
                Icons.calendar_month_rounded,
              ))),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return "$labelText ရွေးပေးပါ";
        }
        return null;
      },
    ),
  );
}

Container customDateInputWithValidation(TextEditingController dateController,
    String labelText, BuildContext context,
    {String? date}) {
  DateTime now = DateTime.now();
  DateTime lastMonth = DateTime(now.year, now.month - 1, 1);
  DateTime firstDateOfLastMonth = DateTime(lastMonth.year, lastMonth.month, 1);

  void pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: date != null ? DateTime.parse(date) : firstDateOfLastMonth,
        lastDate: date != null ? DateTime.now() : DateTime(2101));
    if (pickedDate != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: TextFormField(
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
          labelText: CustomText.getText(context, labelText),
          labelStyle: const TextStyle(fontSize: 14, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: IconButton(
              onPressed: pickDate,
              icon: const Icon(
                Icons.calendar_month_rounded,
              ))),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return "$labelText ရွေးပေးပါ";
        }
        return null;
      },
    ),
  );
}
