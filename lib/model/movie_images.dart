// To parse this JSON data, do
//
//     final movieImages = movieImagesFromJson(jsonString);

import 'dart:convert';

MovieImages movieImagesFromJson(String str) => MovieImages.fromJson(json.decode(str));

String movieImagesToJson(MovieImages data) => json.encode(data.toJson());

class MovieImages {
  final int id;
  final List<Backdrop> backdrops;
  final List<Backdrop> logos;
  final List<Backdrop> posters;

  MovieImages({
    required this.id,
    required this.backdrops,
    required this.logos,
    required this.posters,
  });

  factory MovieImages.fromJson(Map<String, dynamic> json) => MovieImages(
    id: json["id"],
    backdrops: List<Backdrop>.from(json["backdrops"].map((x) => Backdrop.fromJson(x))),
    logos: List<Backdrop>.from(json["logos"].map((x) => Backdrop.fromJson(x))),
    posters: List<Backdrop>.from(json["posters"].map((x) => Backdrop.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
    "logos": List<dynamic>.from(logos.map((x) => x.toJson())),
    "posters": List<dynamic>.from(posters.map((x) => x.toJson())),
  };
}

class Backdrop {
  final double aspectRatio;
  final int height;
  final String? iso31661;
  final String? iso6391;
  final String filePath;
  final double voteAverage;
  final int voteCount;
  final int width;

  Backdrop({
    required this.aspectRatio,
    required this.height,
    required this.iso31661,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
    aspectRatio: json["aspect_ratio"]?.toDouble(),
    height: json["height"],
    iso31661: json["iso_3166_1"],
    iso6391: json["iso_639_1"],
    filePath: json["file_path"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "aspect_ratio": aspectRatio,
    "height": height,
    "iso_3166_1": iso31661,
    "iso_639_1": iso6391,
    "file_path": filePath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "width": width,
  };
}
