import 'package:flutter/material.dart';

Container textBox(String _text, TextEditingController _controller,
    String _error, BuildContext context) {
  return Container(
    width: 240,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black)),
          child: TextField(
            
            autofocus: true,
            style: TextStyle(fontSize: 24),
            controller: _controller,
          ),
        ),
        Text(
          _error,
          style: TextStyle(fontSize: 10, color: Colors.red),
        )
      ],
    ),
  );
}
