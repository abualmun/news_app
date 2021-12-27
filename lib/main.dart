import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/custom.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _usernameError = "";
  String _passwordError = "dont use -,#,@,etc..";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("New App"),
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
              textBox(
                  "User Name", _usernameController, _usernameError, context),
              SizedBox(
                height: 32,
              ),
              textBox("Password", _passwordController, _passwordError, context),
              SizedBox(
                height: 64,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_usernameController.text.isNotEmpty &&
                        _passwordController.text.length >= 8) {
                      print('user name: ${_usernameController.text}' +
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
