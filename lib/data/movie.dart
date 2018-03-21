import 'dart:convert';

import 'package:meta/meta.dart';


class Movie {

  String name, id,year;
  String smallImg,mediumImg,largeImg;
  String originalTitle;
  //评分
  var average;
  //详情
  String alt;
  //分类
  String genres;
  //导演
  String directors;
  //演员
  String casts;


  Movie({@required this.name,
      @required this.id,
      @required this.year,
      @required this.smallImg,
      @required this.mediumImg,
      @required this.largeImg,
      @required this.originalTitle,
      @required this.alt,
      @required this.average,
      @required this.genres,
      @required this.directors,
      @required this.casts,
  });

  static Movie movieResponse(dynamic jsonMovie){
    return formJson(jsonMovie);
  }

  static Movie formJson(dynamic map){
    List directors = map['directors'];
    List casts = map['casts'];
    List genres = map['genres'];

    var d = '';
    for (int i = 0; i < directors.length; i++) {
      if (i == 0) {
        d = d + directors[i]['name'];
      } else {
        d = d + '/' + directors[i]['name'];
      }
    }
    var c = '';
    for (int i = 0; i < casts.length; i++) {
      if (i == 0) {
        c = c + casts[i]['name'];
      } else {
        c = c + '/' + casts[i]['name'];
      }
    }

    var g='';
    for(int i=0;i<genres.length;i++){
      if (i == 0) {
        g = g + genres[i];
      } else {
        g = g + '/' + genres[i];
      }
    }


    return new Movie(
    name: map["title"],
      id: map["id"],
      smallImg: map["images"]["small"],
      mediumImg: map["images"]["medium"],
      largeImg: map["images"]["large"],
      year: map["year"],
      alt: map["alt"],
      average: map["rating"]["average"],
      originalTitle: map["original_title"],
      genres: g,
      directors: d,
      casts: c,
    );

  }

}