import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news/main.dart';
import 'package:news/requirer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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

ConstrainedBox bottomBar(TextEditingController _controller, User user,
    Function refresh, Function loading) {
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
            IconButton(
                onPressed: () async {
                  if (user.loggedin) {
                    loading();
                    final Post post = Post(
                        id: chat.last.id,
                        author: user.username,
                        content: _controller.text,
                        date:
                            DateFormat.jm().format(DateTime.now()).toString());

                    _controller.text = '';
                    final List<Post> newPosts =
                        await sendPost(http.Client(), post);
                    loading();
                    refresh(newPosts);
                  }
                },
                icon: Icon(Icons.send))
          ],
        ),
      ),
    ]),
  );
}

class CustomDrawer extends Drawer {
  final Color backgroundColor;
  final Color itemsColor;
  final Color titleColor;
  final String pageName;
  final List<PageDetails> pages;

  CustomDrawer(
      {this.backgroundColor,
      this.itemsColor,
      this.titleColor,
      this.pages,
      this.pageName}) {
    for (var item in pages) {
      if (item.name == pageName) {
        this.pages.removeWhere((element) => element.name == item.name);
        this.pages.insert(0, item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: this.backgroundColor,
      child: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index > 0)
                  Navigator.popAndPushNamed(context, pages[index].path);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                alignment: Alignment.center,
                child: Text(
                  pages[index].name,
                  style: TextStyle(fontSize: (index == 0) ? 34 : 24),
                ),
                height: (index == 0) ? 56 : 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: (index == 0) ? titleColor : itemsColor),
              ),
            );
          }),
    );
  }
}

class PostCard extends Container {
  final Post _post;

  PostCard(this._post);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _post.author,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green[150]),
              ),
              SizedBox(
                height: 8,
              ),
              Text(_post.content),
            ],
          ),
        ),
        Container(
          child: Text(_post.date),
          height: 16,
          alignment: Alignment.bottomRight,
        )
      ],
    );
  }
}
