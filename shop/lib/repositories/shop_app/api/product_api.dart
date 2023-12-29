import 'dart:convert';

import 'package:shop/repositories/shop_app/api/base_api.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> getProductList(String categoryId, String offset) async {
    const path = '/product/list';
    final params = {
      'categoryId': categoryId,
      'offset': offset,
    };
    final response = await get(path, params: params);
    final data = json.decode(response.body)['data'];

    List<Product> productList = (data as List)
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return productList;
  }

  Future<Product> getProductDetails(String productId) async {
    const path = '/product/details';
    final params = {
      'productId': productId,
    };
    final response = await get(path, params: params);
    final data = json.decode(response.body)['data'];

    Product productDetails = Product.fromJson(data);

    return productDetails;
}}

