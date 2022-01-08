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
  runApp(MaterialApp(
    initialRoute: '/signup',
    routes: {
      '/': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup()
    },
  ));
}

List<Post> chat = [
  Post(id: 0, author: 'ana', content: 'halo', date: '6.02 PM')
];
List<PageDetails> pages = [
  PageDetails('Home', '/'),
  PageDetails('Log in', '/login'),
  PageDetails('Sign up', '/signup')
];

var user = User('', '', false);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    startingChat();
    // });
  }

  startingChat() async {
    final List<Post> newPosts = await fetchPosts(http.Client(), chat[0].id);
    refresh(newPosts);
  }

  final _pages = pages;

  var _textController = TextEditingController();

  refresh(List<Post> posts) {
    setState(() {
      chat.addAll(posts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final List<Post> newPosts =
      //         await fetchPosts(http.Client(), chat[0].id);
      //     refresh(newPosts);
      //   },
      // ),
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
            final rIndex = chat.length - index - 1;

            return PostCard(chat[rIndex]);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomBar(_textController, user, refresh),
        ),
      ]),
    );
  }
}
