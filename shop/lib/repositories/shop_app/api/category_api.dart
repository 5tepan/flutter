import 'base_api.dart';
import 'package:shop/repositories/shop_app/models/category.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> getCategoryList() async {
    const path = '/category/list';
    final response = await get(path);
    final data = response.data['data'];

    List<Category> categoryList = (data['categories'] as List)
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();

    categoryList.retainWhere((category) =>
    category.categoryId != null &&
        category.title != null &&
        category.imageUrl != null);

    return categoryList;
  }
}
