import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:news/custom.dart';
import 'package:news/requirer.dart';
import 'package:news/signup.dart';
import 'login.dart';
import 'requirer.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/chat': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup()
    },
  ));
}
// this is where you store the required "Posts" from the API
List<Post> chat = [
  Post(id: 0, author: 'ana', content: 'halo', date: '6.02 PM')];

// this is where you store the user information
var user = User('', '', false);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // loading is variable to hide/show the loading icon
  bool _loading = false;
  var _textController = TextEditingController();
  
  
  @override
  void initState() {
    startingChat();
    super.initState();
  }

  startingChat() async {
    setState(() {
      _loading = true;
    });
    final List<Post> newPosts = await fetchPosts(http.Client(), chat.last.id);
    setState(() {
      _loading = false;
    });
    refresh(newPosts);
  }

 
  void loadingIcon() {
    setState(() {
      _loading = !_loading;
    });
  }

  refresh(List<Post> posts) {
    setState(() {
      chat.addAll(posts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            setState(() {
              _loading = true;
            });
            final List<Post> newPosts =
                await fetchPosts(http.Client(), chat.last.id);
            print(chat.map((e) => e.id).toList());

            refresh(newPosts);
            setState(() {
              _loading = false;
            });
          },
          icon: Icon(Icons.refresh),
        ),
      ),
      body: Stack(children: [
        ListView.builder(
          padding: EdgeInsets.only(bottom: 64),
          itemCount: chat.length,
          itemBuilder: (context, index) {
            final rIndex = chat.length - index - 1;

            return (user.username == chat[rIndex].author)
                ? Align(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: PostCard(chat[rIndex]),
                    ),
                    alignment: Alignment.centerRight,
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: PostCard(chat[rIndex]),
                  );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomBar(_textController, user, refresh, loadingIcon),
        ),
        if (_loading)
          Opacity(
              opacity: .2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey,
              )),
        if (_loading) Center(child: CircularProgressIndicator())
      ]),
    );
  }
}
