import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int productId;
  final int price;

  @JsonKey(defaultValue: '')
  final String imageUrl;

  @JsonKey(defaultValue: '')
  final String productDescription;

  @JsonKey(defaultValue: '')
  final String title;

  @JsonKey(defaultValue: [])
  final List<String> images;

  @JsonKey(defaultValue: 0)
  final int isAvailableForSale;

  Product({
    required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.isAvailableForSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
