class Category {
  final String title;
  final String imageUrl;
  final int categoryId;

  const Category(
      {required this.title, required this.imageUrl, required this.categoryId});

  // TODO: https://docs.flutter.dev/data-and-backend/serialization/json#serializing-json-using-code-generation-libraries
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      categoryId: json['categoryId'] as int,
    );
  }
}
