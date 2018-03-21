import 'package:meta/meta.dart';


class MovieDetail {

  String smallImg, mediumImg, largeImg;
  String id;
  String summary;
  String aka;
  String countries;
  String title;
  String originalTitle;
  String casts;
  String directors;
  String genres;
  String year;
  var average;
  var ratingsCount;

  MovieDetail({
    @required this.title,
    @required this.id,
    @required this.year,
    @required this.smallImg,
    @required this.mediumImg,
    @required this.largeImg,
    @required this.originalTitle,
    @required this.average,
    @required this.genres,
    @required this.directors,
    @required this.casts,
    @required this.countries,
    @required this.aka,
    @required this.summary,
    @required this.ratingsCount,
  });

  static MovieDetail detailsResponse(dynamic jsonMovie){
    return formJson(jsonMovie);
  }


  static MovieDetail formJson(dynamic map){
    List directors = map['directors'];
    List casts = map['casts'];
    List genres = map['genres'];
    List akas = map['aka'];
    List countries = map['countries'];

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

    var aka='';
    for(int i=0;i<akas.length;i++){
      if (i == 0) {
        aka = aka + akas[i];
      } else {
        aka = aka + '/' + akas[i];
      }
    }
    var country='';
    for(int i=0;i<countries.length;i++){
      if (i == 0) {
        country = country + countries[i];
      } else {
        country = country + '/' + countries[i];
      }
    }


    return new MovieDetail(
      title: map["title"],
      id: map["id"],
      smallImg: map["images"]["small"],
      mediumImg: map["images"]["medium"],
      largeImg: map["images"]["large"],
      year: map["year"],
      average: map["rating"]["average"],
      originalTitle: map["original_title"],
      countries:country,
      summary: map["summary"],
      ratingsCount: map["ratings_count"],
      aka: aka,
      genres: g,
      directors: d,
      casts: c,
    );

  }
}