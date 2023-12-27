import 'package:shop/features/category_grid/view/category_grid_page.dart';
import 'package:shop/features/product_grid/view/product_grid_page.dart';
import 'package:shop/features/product_page/product_page.dart';

// TODO: Не использовать переменные root уровня.
// Заменить навигацию с .pushNamed() на .push(),
// а переменную routes на класс AppRoutes c методами вида
// MaterialPageRoute productList(int categoryId) => MaterialPageRoute(builder: ProductGridPage(categoryId));
// В крупных проектах навигация основанная на именах становится очень сложной. Поэтому мы выбрали более простой и лучше контролируемый вариант с методами-билдерами для MaterialPageRoute
final routes = {
  '/': (context) => CategoryGridPage(),
  '/product_grid_page': (context) => ProductGridPage(),
  '/product_page': (context) => ProductCardPage(),
};
