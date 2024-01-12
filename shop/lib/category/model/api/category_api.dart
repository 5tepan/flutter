import 'dart:convert';

import 'package:shop/core/model/api/base_api.dart';
import 'package:shop/category/model/entities/category.dart';

class CategoryApi extends BaseApi {
  Future<List<Category>> getCategoryList() async {
    const path = '/category/list';
    final response = await get(path);
    final data = json.decode(response.body)['data'];

    List<Category> categoryList = (data['categories'] as List)
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();

    return categoryList;
  }
}
