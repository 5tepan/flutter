import 'package:flutter/material.dart';
import 'package:shop/category/category_grid_page.dart';
import 'package:shop/product/product_grid_page.dart';
import 'package:shop/product/product_card_page.dart';
import 'package:shop/category/model/entities/category.dart';

class AppRoutes {
  static MaterialPageRoute categoryList() =>
      MaterialPageRoute(builder: (context) => CategoryGridPage());

  static MaterialPageRoute productList(Category category) =>
      MaterialPageRoute(builder: (context) => ProductGridPage(category: category));

  static MaterialPageRoute productPage(int productId) =>
      MaterialPageRoute(builder: (context) => ProductCardPage(productId: productId));
}
