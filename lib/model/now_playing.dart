// To parse this JSON data, do
//
//     final nowPlaying = nowPlayingFromJson(jsonString);

import 'dart:convert';

NowPlaying nowPlayingFromJson(String str) => NowPlaying.fromJson(json.decode(str));

String nowPlayingToJson(NowPlaying data) => json.encode(data.toJson());

class NowPlaying {
  final Dates? dates;
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  NowPlaying({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory NowPlaying.fromJson(Map<String, dynamic> json) => NowPlaying(
    dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
    page: json["page"] ?? 1,
    results: json["results"] == null
        ? []
        : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"] ?? 1,
    totalResults: json["total_results"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  final DateTime? maximum;
  final DateTime? minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.tryParse(json["maximum"]?.toString() ?? ""),
    minimum: DateTime.tryParse(json["minimum"]?.toString() ?? ""),
  );

  Map<String, dynamic> toJson() => {
    "maximum": maximum == null
        ? null
        : "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
    "minimum": minimum == null
        ? null
        : "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
  };
}

class Result {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final bool softcore;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.softcore,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] == null
        ? []
        : List<int>.from(json["genre_ids"].map((x) => x as int)),
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    originalLanguage: json["original_language"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: (json["popularity"] as num?)?.toDouble() ?? 0.0,
    posterPath: json["poster_path"],
    releaseDate: DateTime.tryParse(json["release_date"]?.toString() ?? ""),
    softcore: json["softcore"] ?? false,
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] as num?)?.toDouble() ?? 0.0,
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "title": title,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate == null
        ? null
        : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "softcore": softcore,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
