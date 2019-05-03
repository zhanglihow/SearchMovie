import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search_movie/data/movie.dart';
import 'package:search_movie/net/repository.dart';
import 'package:search_movie/pages/movie_details_page.dart';
import 'package:search_movie/utils/utils.dart';
import 'package:search_movie/widget/movie_card.dart';
import 'dart:async';

class SearchMoviePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }
}

class SearchState extends State<SearchMoviePage> {
  SearchState();

  List<Movie> _items = new List();
  final subject = new PublishSubject<String>();
  bool _isLoading = false;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("查询电影APP"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(hintText: "电影名称"),
              onChanged: (string) => (subject.add(string)),
            ),
            _isLoading
                ? new Center(child: new CircularProgressIndicator())
                : new Container(),
            new Expanded(
                child: new ListView.builder(
                    padding: new EdgeInsets.all(8.0),
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new MovieCard(
                        movie: _items[index],
                        itemClick: () {
                          Navigator.of(context).push(new FadeRoute(
                            builder: (BuildContext context) =>
                                new MovieDetailsPage(_items[index]),
                            settings: new RouteSettings(
                                name: '/movie', isInitialRoute: false),
                          ));
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }

  void _clearList() {
    setState(() {
      _items.clear();
    });
  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subject.stream
        .debounce(new Duration(milliseconds: 600))
        .listen(_textChanged);
  }

  void _textChanged(String text) {
    if (text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _clearList();
    Repository.getMovies(text).then((movie) {
      setState(() {
        _isLoading = false;
        if (movie.isOk()) {
          _items = movie.body;
        } else {
          scaffoldKey.currentState.showSnackBar(new SnackBar(
              content: new Text(
                  "Something went wrong, check your internet connection")));
        }
      });
    });
  }
}
