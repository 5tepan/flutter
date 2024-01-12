import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String title;
  final String imageUrl;
  final int categoryId;

  const Category({
    required this.title,
    required this.imageUrl,
    required this.categoryId
  });

  // TODO: https://docs.flutter.dev/data-and-backend/serialization/json#serializing-json-using-code-generation-libraries ##
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
