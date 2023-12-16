import 'base_api.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

class ProductApi extends BaseApi {
  Future<List<Product>> getProductList(String categoryId, int offset) async {
    const path = '/product/list';
    final params = {
      'categoryId': categoryId,
      'offset': offset,
    };
    final response = await get(path, params: params);
    final data = response.data['data'];

    List<Product> productList = (data as List)
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return productList;
  }
}

