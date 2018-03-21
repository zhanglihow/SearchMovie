import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_movie/data/movie.dart';
import 'package:search_movie/data/movie_detail.dart';
import 'package:search_movie/net/repository.dart';


class MovieDetailsPage extends StatefulWidget {

  final Movie movie;

  MovieDetailsPage(this.movie);

  @override
  State<StatefulWidget> createState() {
    return new MovieDetailsState();
  }
}

class MovieDetailsState extends State<MovieDetailsPage> {
  MovieDetail details;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    Repository.getMovieDetails(widget.movie.id)
        .then((movieDetails) {
      setState(() {
        if (movieDetails.isOk()) {
          details = movieDetails.body;
        } else {
          scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(
              "Something went wrong, check your internet connection")));
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    var content;
    if (details == null) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = setContent(details);
      new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: content,
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            widget.movie.name + " " +
                widget.movie.originalTitle + " (" +
                widget.movie.year + ")"
        ),
      ),
      body: content,

    );
  }

  setContent(MovieDetail details) {
    var movieImage = new Hero(
      tag: details.id,
      child: new Center(
        child: new Image.network(
          details.largeImg,
        ),
      ),
    );

    var movieMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,

      children: <Widget>[
        new Align(
          child: new Text(
            "\n" + details.title + " " +
                details.originalTitle + " (" +
                details.year + ")",
            textAlign: TextAlign.left,
            style: new TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17.0,
                letterSpacing: 1.2
            ),
          ),
          alignment: Alignment.topLeft,
        ),
        new RichText(
          text: new TextSpan(
            style: new TextStyle(
                inherit: true, fontSize: 15.0,
                letterSpacing: 1.1),
            children: <TextSpan>[
              new TextSpan(
                  text: '\n导演：',
                  style: new TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: details.directors,
                  style: new TextStyle(color: Colors.black)),
              new TextSpan(
                  text: '\n主演：',
                  style: new TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: details.casts,
                  style: new TextStyle(color: Colors.black)),
              new TextSpan(
                  text: '\n类型：',
                  style: new TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: details.genres,
                  style: new TextStyle(color: Colors.black)),
              new TextSpan(
                  text: '\n制片国家/地区：',
                  style: new TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: details.countries,
                  style: new TextStyle(color: Colors.black)),
              new TextSpan(
                  text: "\n\n评分：", style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: details.average.toString(),
                  style: new TextStyle(color: Colors.red)),
              new TextSpan(
                  text: " (" + details.ratingsCount.toString() + " 人评价)",
                  style: new TextStyle(color: Colors.black)),
              new TextSpan(
                  text: '\n\n剧情简介：',
                  style: new TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              new TextSpan(
                  text: details.summary,
                  style: new TextStyle(
                      color: Colors.black, letterSpacing: 1.0)),
            ],
          ),
        ),
      ],
    );

    return new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child:
        new Scrollbar(
            child: new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    movieImage,
                    movieMsg,
                  ],
                )
            )
        )
    );
  }

}