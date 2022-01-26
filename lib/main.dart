import 'package:flutter/material.dart';
import 'package:vaccination/pages/auth.dart';
import 'package:vaccination/pages/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authentication());}}
