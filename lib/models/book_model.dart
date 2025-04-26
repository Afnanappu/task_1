class BookModel {
  BookModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final num? count;
  final dynamic next;
  final dynamic previous;
  final List<Result> results;

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results:
          json["results"] == null
              ? []
              : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x)),
              ),
    );
  }
}

class Result {
  Result({required this.id, required this.title});

  final int? id;
  final String? title;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(id: json["id"], title: json["title"]);
  }
}
