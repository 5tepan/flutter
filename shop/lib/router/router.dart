import 'package:shop/features/category_grid/view/category_grid_page.dart';
import 'package:shop/features/product_grid/view/product_grid_page.dart';
import 'package:shop/features/product_page/product_page.dart';


final routes = {
  '/': (context) => CategoryGridPage(),
  '/product_grid_page': (context) => ProductGridPage(),
  '/product_page': (context) => ProductCardPage(),
};