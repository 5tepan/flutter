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

    // TODO: Два замечания:
    // 1. Стараемся не использовать клиентскую фильтрацию данных. Т.к. это может привести к незапланированному поведению в приложении
    // 2. Если один из параметров будет null, то приложение уже выкинет исключение на методе Category.fromJson(categoryJson))
    categoryList.retainWhere((category) =>
        category.categoryId != null &&
        category.title != null &&
        category.imageUrl != null);

    return categoryList;
  }
}
