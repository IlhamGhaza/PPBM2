import 'dart:convert';

class BookResponseModel {
  final int? id;
  final String? title;
  final String? author;
  final int? year;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BookResponseModel({
    this.id,
    this.title,
    this.author,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  factory BookResponseModel.fromJson(String str) =>
      BookResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookResponseModel.fromMap(Map<String, dynamic> json) =>
      BookResponseModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        year:
            json["year"] is int
                ? json["year"]
                : (json["year"] is String ? int.tryParse(json["year"]) : null),
        createdAt:
            (json["created_at"] != null &&
                    json["created_at"] is String &&
                    (json["created_at"] as String).isNotEmpty)
                ? DateTime.tryParse(json["created_at"])
                : null,
        updatedAt:
            (json["updated_at"] != null &&
                    json["updated_at"] is String &&
                    (json["updated_at"] as String).isNotEmpty)
                ? DateTime.tryParse(json["updated_at"])
                : null,
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "author": author,
    "year": year,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  BookResponseModel copyWith({
    int? id,
    String? title,
    String? author,
    int? year,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookResponseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      year: year ?? this.year,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
