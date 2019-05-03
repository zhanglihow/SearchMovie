import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:search_movie/data/movie.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final VoidCallback itemClick;

  MovieCard({this.movie, @required this.itemClick});

  @override
  State<StatefulWidget> createState() {
    return new MovieCardState();
  }
}

class MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: widget.itemClick,
      child: new Card(
        child: new Container(
          height: 200.0,
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new Row(
              children: <Widget>[
                widget.movie.smallImg != null
                    ? new Hero(
                        child: new Image.network(
                          widget.movie.smallImg,
                          width: 140.0,
                        ),
                        tag: widget.movie.id,
                      )
                    : new Container(),
                new Expanded(
                    child: new Column(
                  children: <Widget>[
                    new Align(
                      child: new Padding(
                        child: new Text(
                          widget.movie.name +
                              " " +
                              widget.movie.originalTitle +
                              " (" +
                              widget.movie.year +
                              ")",
                          maxLines: 2,
                          style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        padding: new EdgeInsets.all(8.0),
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    new Align(
                      child: new Padding(
                        child: new Text(
                          "评分：" +
                              widget.movie.average.toString() +
                              "\n" +
                              widget.movie.directors +
                              "\n" +
                              widget.movie.casts +
                              "\n" +
                              widget.movie.genres,
                          maxLines: 4,
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                        padding: new EdgeInsets.all(8.0),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
