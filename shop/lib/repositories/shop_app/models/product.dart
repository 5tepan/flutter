class Product {
  final int productId;
  final String title;
  final String productDescription;
  final int price;
  final String imageUrl;
  final List<String> images;
  final bool isAvailableForSale;

  Product({
    required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.isAvailableForSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] as int,
      title: json['title'] as String? ?? '',
      productDescription: json['productDescription'] as String? ?? '',
      price: (json['price'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      images: List<String>.from(json['images'] ?? []),
      isAvailableForSale: json['isAvailableForSale'] == 1,
    );
  }
}
