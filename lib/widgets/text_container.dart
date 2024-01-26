import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  String value;
  String label;
  TextContainer(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(width: 90),
          Flexible(
               child: new Text(value))
                ],
      ),
    );
    
  }
}
