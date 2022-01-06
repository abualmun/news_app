import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/custom.dart';
import 'package:news/requirer.dart';
import 'package:news/signup.dart';
import 'login.dart';
import 'requirer.dart';

void main() {
  // chat.add(Post('author', 'content', 'date'));

  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup()
    },
  ));
}

List<PageDetails> pages = [
  PageDetails('Home', '/'),
  PageDetails('Log in', '/login'),
  PageDetails('Sign up', '/signup')
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = User('', '', true);
  final _pages = pages;

  var _textController = TextEditingController();

  List<Post> chat = [
    Post('author', 'content', 'date'),
    Post('abualmun', 'shabissssssssssssssssssssssssssdabido \n hhh', '2022')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(
        backgroundColor: Colors.lightBlue,
        itemsColor: Colors.grey,
        titleColor: Colors.green,
        pageName: 'Home',
        pages: _pages,
      ),
      body: Stack(children: [
        ListView.builder(
          itemCount: chat.length,
          itemBuilder: (context, index) {
            return PostCard(chat[index]);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomBar(_textController, user),
        ),
      ]),
    );
  }
}
