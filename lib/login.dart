import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/requirer.dart';
import 'custom.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _usernameError = "";
  String _passwordError = "";
  final _pages = pages;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("New App"),
        ),
        drawer:CustomDrawer(
        backgroundColor: Colors.lightBlue,
        itemsColor: Colors.grey,
        titleColor: Colors.green,
        pageName: 'Log in',
        pages: _pages,
      ) ,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log in",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 96,
              ),
              textBox("Username", _usernameController, _usernameError, false),
              SizedBox(
                height: 32,
              ),
              textBox("Password", _passwordController, _passwordError, true),
              SizedBox(
                height: 64,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.length >= 8) {
                      final validLogin = await tryLogin(
                          _usernameController.text, _passwordController.text);
                      if (validLogin) {
                        print('username: ${_usernameController.text}' +
                            '\n' +
                            'Password : ${_passwordController.text}');

                        setState(() {
                          _usernameError = "";
                          _passwordError = "";
                        });
                      }
                    } else if (_usernameController.text.isEmpty) {
                      setState(() {
                        _usernameError = "Enter a username!";
                      });
                    } else if (_passwordController.text.length <= 8) {
                      setState(() {
                        _passwordError = "Password too short!";
                      });
                    }
                  },
                  child: Text('Log in'))
            ],
          ),
        ),
      ),
    );
  }
}
