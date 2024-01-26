import 'package:union/utils/custom_text.dart';
import 'package:flutter/material.dart';

Container customTextInput(TextEditingController inputController,
    String labelText, String? type, BuildContext context) {
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        maxLines: type == 'textarea' ? 5 : 1,
        controller: inputController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          alignLabelWithHint: true,
          labelText: CustomText.getText(context, labelText),
          labelStyle: const TextStyle(fontSize: 14, color: Colors.blue),
        ),
        keyboardType:
            type == 'number' ? TextInputType.number : TextInputType.text,
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$labelText is Required';
          }
          return null;
        },
      ));
}

Container customTextInputWithValidator(
    TextEditingController inputController,
    String labelText,
    String? type,
    String? Function(String?)? validate,
    BuildContext context) {
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
          maxLines: type == 'textarea' ? 5 : 1,
          controller: inputController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            alignLabelWithHint: true,
            labelText: CustomText.getText(context, labelText),
            labelStyle: const TextStyle(fontSize: 14, color: Colors.blue),
          ),
          style: const TextStyle(
            fontFamily: 'EnglishFont',
          ),
          keyboardType:
              type == 'number' ? TextInputType.number : TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: validate));
}
