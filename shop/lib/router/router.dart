import 'package:flutter/material.dart';
import 'package:shop/features/category_grid/view/category_grid_page.dart';
import 'package:shop/features/product_grid/view/product_grid_page.dart';
import 'package:shop/features/product_page/view/product_card_page.dart';
import 'package:shop/repositories/shop_app/models/category.dart';

// TODO: Не использовать переменные root уровня. ##
// Заменить навигацию с .pushNamed() на .push(),
// а переменную routes на класс AppRoutes c методами вида
// MaterialPageRoute productList(int categoryId) => MaterialPageRoute(builder: ProductGridPage(categoryId));
// В крупных проектах навигация основанная на именах становится очень сложной. Поэтому мы выбрали более простой и лучше контролируемый вариант с методами-билдерами для MaterialPageRoute

class AppRoutes {
  static MaterialPageRoute categoryList() =>
      MaterialPageRoute(builder: (context) => CategoryGridPage());

  static MaterialPageRoute productList(Category category) =>
      MaterialPageRoute(builder: (context) => ProductGridPage(category: category));

  static MaterialPageRoute productPage(int productId) =>
      MaterialPageRoute(builder: (context) => ProductCardPage(productId: productId));
}
