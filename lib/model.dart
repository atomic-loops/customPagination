import 'dart:convert';

Demomodel demomodelFromJson(String str) => Demomodel.fromJson(json.decode(str));

String demomodelToJson(Demomodel data) => json.encode(data.toJson());

class Demomodel {
  Data data;
  Error error;
  bool isSuccess;

  Demomodel({
    required this.data,
    required this.error,
    required this.isSuccess,
  });

  factory Demomodel.fromJson(Map<String, dynamic> json) => Demomodel(
        data: Data.fromJson(json["data"]),
        error: Error.fromJson(json["error"]),
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error.toJson(),
        "isSuccess": isSuccess,
      };
}

class Data {
  int count;
  int currentPage;
  int totalPages;
  dynamic next;
  dynamic previous;
  List<Result> results;

  Data({
    required this.count,
    required this.currentPage,
    required this.totalPages,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String id;

  String name;
  String emoji;

  Result({
    required this.id,
    required this.name,
    required this.emoji,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "emoji": emoji,
      };
}

class Error {
  Error();

  factory Error.fromJson(Map<String, dynamic> json) => Error();

  Map<String, dynamic> toJson() => {};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
