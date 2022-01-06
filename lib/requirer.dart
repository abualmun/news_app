import 'dart:convert';

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
}

class Post {
  final String author;
  final String content;
  final String date;

  Post(this.author, this.content, this.date);

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
      'date': date,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json['author'], json['content'], json['date']);
  }
}

Future<void> getChatData(Post lastPost) async {
  final res =
      await http.post(Uri.parse('localhost:8000'), body: lastPost.content);
  if (res.statusCode == 200) {
    Iterable posts = json.decode(res.body);
    // posts.map((post) => {chat.add(Post.fromJson(post))});
  } else {
    throw Exception('failed to reach server.');
  }
}

void sendPost(Post post, Post lastPost) async {
  final res = await http.post(Uri.parse('localhost:8000'), body: post.toMap());
  if (res.statusCode == 200) {
    await getChatData(lastPost);
  } else {
    throw Exception('failed to reach server.');
  }
}

Future<bool> tryLogin(String username, String password) async {
  final res = await http.post(Uri.parse('localhost:8000'),
      body: {'username': username, 'password': password});
  if (res.statusCode == 200) {
    return (json.decode(res.body)['match'] == 'true');
  } else {
    throw Exception('failed to reach server');
  }
}


