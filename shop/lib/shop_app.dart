import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/repositories/shop_app/api/category_api.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/router/router.dart';
import 'package:shop/theme/theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ProductApi>(
            create: (_) => ProductApi(),
          ),
          Provider<CategoryApi>(
            create: (_) => CategoryApi(),
          ),
        ],
        child: MaterialApp(
            title: 'Shop',
            theme: AppThemes.darkTheme,
            home: AppRoutes.categoryList().builder(context)));
  }
}
