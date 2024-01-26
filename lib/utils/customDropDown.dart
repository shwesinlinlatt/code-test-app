import 'package:flutter/material.dart';

Container customDropDown(String title, List<DropdownMenuItem<String>> items,
    String? selectedData, String? hintText, void Function(dynamic)? onChanged,
    {bool isRequired = true}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title,
        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        // ),
        // const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.purpleAccent),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              isDense: true,
            ),
            itemHeight: 50,
            hint: Text(
              '$hintText',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.blue,
              ),
            ),
            isExpanded: true,
            value: selectedData,
            items: items.toList(),
            onChanged: onChanged,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
            ),
            validator: isRequired
                ? (value) => value == null ? '$title is required' : null
                : null,
            iconSize: 42,
          ),
        ),
      ],
    ),
  );
}
