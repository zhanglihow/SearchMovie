import 'package:flutter/material.dart';
import 'package:search_movie/pages/search_movie_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new SearchMoviePage(),
    );
  }

}
