// To parse this JSON data, do
//
//     final movieList = movieListFromJson(jsonString);

import 'dart:convert';

MovieList movieListFromJson(String str) => MovieList.fromJson(json.decode(str));

String movieListToJson(MovieList data) => json.encode(data.toJson());

class MovieList {
  final List<Genre> genres;

  MovieList({
    required this.genres,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
    genres: json["genres"] == null
        ? []
        : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
  };
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
