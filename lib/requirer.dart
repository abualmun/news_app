import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart';
    final socket = io("http://192.168.43.159:5000", <String, dynamic>{
  "transports": ["websocket"],
  "autoConnect": false,
});

class User {
  final String username;
  final String password;
  final bool loggedin;
  User(this.username, this.password, this.loggedin);
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class Post {
  final int id;
  final String author;
  final String content;
  final String date;

  Post({this.author, this.content, this.date, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'date': date,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] as int,
        author: json['author'],
        content: json['content'],
        date: json['date']);
  }
}

List<Post> parsePosts(responseBody) {
  return responseBody.map<Post>((json) => Post.fromJson(json)).toList();
}



Future<String> tryLogin(String username, String password) async {
  try {
    final response = await http.Client()
        .post(Uri.parse('http://192.168.43.159:5000/users/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'username': username, 'password': password}));
    if (response.statusCode == 200) return response.body;
  } catch (err) {
    return 'connection problem';
  }
}

Future<String> trySignup(String username, String password) async {
  try {
    final response = await http.Client()
        .post(Uri.parse('http://192.168.43.159:5000/users'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: json.encode({'username': username, 'password': password}));
    if (response.statusCode == 200) return response.body;
  } catch (err) {
    return 'connection problem';
  }
}
