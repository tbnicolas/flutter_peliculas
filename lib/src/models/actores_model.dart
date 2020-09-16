import 'dart:convert';

class Cast{

  List<Actor> actores = new List();
  Cast.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    jsonList.forEach((item){
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}





class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });
  Actor.fromJsonMap(Map<String, dynamic> json){
    this.castId       =  json['cast_id'];
    this.character    =  json['character'];
    this.creditId     =  json['credit_id'];
    this.gender       =  json['gender'];
    this.id           =  json['id'];
    this.name         =  json['name'];
    this.order        =  json['oder'];
    this.profilePath  =  json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://lh3.googleusercontent.com/proxy/GSl3mAZR37LlO7P8m4vMTP3X9EGlff_ffPQzC152Ze-0Dxy6WP7UU5nIS58GUMFY7EMLsnq7QB87M3-Eusw2rKokJYgJqQOC3EMM_bZkoayTVOQ';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
