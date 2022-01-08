import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class PageDetails {
  final String name;
  final String path;

  PageDetails(this.name, this.path);
}

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

List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<List<Post>> fetchPosts(http.Client client, int lastid) async {
  final response = await client.post(
      Uri.parse('https://abualmun-news-api.herokuapp.com/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'id': '1'}));
  print(parsePosts(response.body));

  return parsePosts(response.body);
}

Future<List<Post>> sendPost(http.Client client, Post post) async {
  final response = await client.post(
      Uri.parse('https://abualmun-news-api.herokuapp.com/chat/post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(post.toMap()));

  return compute(parsePosts, response.body);
}

Future<bool> tryLogin(String username, String password) async {
  final response =
      await http.Client().post(Uri.parse('https://abualmun-news-api.herokuapp.com/users/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({'username': username, 'password': password}));
  return response.body == 'success';
}
Future<bool> trySignup(String username, String password) async {
  final response = await http.Client()
      .post(Uri.parse('https://abualmun-news-api.herokuapp.com/users'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({'username': username, 'password': password}));
  return response.body == 'success';
}
