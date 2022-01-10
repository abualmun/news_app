import 'package:flutter/material.dart';
import 'custom.dart';
import 'requirer.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _usernameError = "";
  String _passwordError = "dont use -,#,@,etc..";
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
                          final validSignup = await trySignup(
                              _usernameController.text,
                              _passwordController.text);
                          setState(() {
                            _loading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(validSignup)));
                          if (validSignup == 'success') {
                            Navigator.popAndPushNamed(context, '/login');
                          }
                          setState(() {
                            _usernameError = "";
                            _passwordError = "";
                          });
                        } else if (_usernameController.text.isEmpty) {
                          setState(() {
                            _usernameError = "Enter a username!";
                          });
                        } else if (_passwordController.text.length <= 8) {
                          setState(() {
                            _passwordError =
                                "Password too short!..min 8 chatacters.";
                          });
                        }
                      },
                      child: Text('Sign up')),
                  SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, '/login'),
                      child: Text('go to Log in page'))
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
