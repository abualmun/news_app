import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

}

void getChatData()async{

  
}



