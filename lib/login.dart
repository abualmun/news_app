import 'package:flutter/material.dart';
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
    // loading is variable to hide/show the loading icon
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New App"),
        ),
        body: Stack(children: [
          Center(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_usernameController.text.isNotEmpty &&
                              _passwordController.text.length >= 8) {
                            setState(() {
                              _loading = true;
                            });
                            final validLogin = await tryLogin(
                                _usernameController.text,
                                _passwordController.text);
                            setState(() {
                              _loading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(validLogin)));
                            if (validLogin == 'success') {
                              user = User(_usernameController.text,
                                  _passwordController.text, true);
                              Navigator.popAndPushNamed(context, '/chat');
                              setState(() {
                                _usernameError = "";
                                _passwordError = "";
                              });
                            } else {
                              print('Failed');
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
                        child: Text('Log in')),
                    SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, '/signup'),
                        child: Text('go to Sign up page'))
                  ],
                )
              ],
            ),
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
