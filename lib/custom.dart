import 'dart:ui';

import 'package:flutter/material.dart';

Container textBox(String _text, TextEditingController _controller,
    String _error, bool _hideCharacters) {
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
            obscuringCharacter: '*',
            obscureText: _hideCharacters,
            autofocus: true,
            style: TextStyle(fontSize: 16),
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

ConstrainedBox bottomBar(TextEditingController _controller) {
  return ConstrainedBox(
    constraints: BoxConstraints(minHeight: 40),
    child: Wrap(children: [
      Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            color: Colors.lightGreen,
            border: Border(),
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15), right: Radius.circular(15))),
        margin: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),
            Expanded(
                child: TextField(
              selectionHeightStyle: BoxHeightStyle.max,
              maxLines: null,
              minLines: null,
              controller: _controller,
              decoration: InputDecoration(hintText: 'Yaburu Ai no Kokuhaku..'),
            )),
            IconButton(onPressed: () {}, icon: Icon(Icons.send))
          ],
        ),
      ),
    ]),
  );
}
