import 'package:flutter/material.dart';
import 'package:shop/repositories/shop_app/api/category_api.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/router/router.dart';
import 'package:shop/theme/theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      theme: darkTheme,
      routes: routes,
    );
  }

  static ProductApi getProductApi() => ProductApi();
  static CategoryApi getCategoryApi() => CategoryApi();
}