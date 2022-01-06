


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom.dart';
import 'main.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _usernameError = "";
  String _passwordError = "dont use -,#,@,etc..";
  final _pages = pages;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("New App"),
        ),drawer: CustomDrawer(
        backgroundColor: Colors.lightBlue,
        itemsColor: Colors.grey,
        titleColor: Colors.green,
        pageName: 'Sign up',
        pages: _pages,
      ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign up for FREE!!",
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
                  onPressed: () {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.length >= 8) {
                      print('username: ${_usernameController.text}' +
                          '\n' +
                          'Password : ${_passwordController.text}');

                      setState(() {
                        _usernameError = "";
                        _passwordError = "dont use -,#,@,etc..";
                      });
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
                  child: Text('Sign up'))
            ],
          ),
        ),
      ),
    );
  }
}
