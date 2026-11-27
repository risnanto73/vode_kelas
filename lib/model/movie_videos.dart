// To parse this JSON data, do
//
//     final movieVideos = movieVideosFromJson(jsonString);

import 'dart:convert';

MovieVideos movieVideosFromJson(String str) => MovieVideos.fromJson(json.decode(str));

String movieVideosToJson(MovieVideos data) => json.encode(data.toJson());

class MovieVideos {
  final int id;
  final List<Result> results;

  MovieVideos({
    required this.id,
    required this.results,
  });

  factory MovieVideos.fromJson(Map<String, dynamic> json) => MovieVideos(
    id: json["id"] ?? 0,
    results: json["results"] == null
        ? []
        : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  final Iso6391 iso6391;
  final Iso31661 iso31661;
  final String name;
  final String key;
  final Site site;
  final int size;
  final Type type;
  final bool official;
  final String id;
  final DateTime? publishedAt;

  Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.id,
    required this.publishedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    iso6391: iso6391Values.map[json["iso_639_1"]] ?? Iso6391.OTHER,
    iso31661: iso31661Values.map[json["iso_3166_1"]] ?? Iso31661.OTHER,
    name: json["name"] ?? "",
    key: json["key"] ?? "",
    site: siteValues.map[json["site"]] ?? Site.OTHER,
    size: json["size"] ?? 0,
    type: typeValues.map[json["type"]] ?? Type.CLIP,
    official: json["official"] ?? false,
    id: json["id"] ?? "",
    publishedAt: DateTime.tryParse(json["published_at"]?.toString() ?? ""),
  );

  Map<String, dynamic> toJson() => {
    "iso_639_1": iso6391Values.reverse[iso6391],
    "iso_3166_1": iso31661Values.reverse[iso31661],
    "name": name,
    "key": key,
    "site": siteValues.reverse[site],
    "size": size,
    "type": typeValues.reverse[type],
    "official": official,
    "id": id,
    "published_at": publishedAt?.toIso8601String(),
  };
}

enum Iso31661 {
  US,
  OTHER,
}

final iso31661Values = EnumValues({
  "US": Iso31661.US,
  "OTHER": Iso31661.OTHER,
});

enum Iso6391 {
  EN,
  OTHER,
}

final iso6391Values = EnumValues({
  "en": Iso6391.EN,
  "other": Iso6391.OTHER,
});

enum Site {
  YOU_TUBE,
  OTHER,
}

final siteValues = EnumValues({
  "YouTube": Site.YOU_TUBE,
  "Other": Site.OTHER,
});

enum Type {
  BEHIND_THE_SCENES,
  CLIP,
  FEATURETTE,
  TEASER,
  TRAILER
}

final typeValues = EnumValues({
  "Behind the Scenes": Type.BEHIND_THE_SCENES,
  "Clip": Type.CLIP,
  "Featurette": Type.FEATURETTE,
  "Teaser": Type.TEASER,
  "Trailer": Type.TRAILER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
