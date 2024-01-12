import 'package:shop/core/model/base_data_model.dart';
import 'package:shop/product/model/api/product_api.dart';
import 'package:shop/product/model/entities/product.dart';

class ProductCardModel extends BaseModel<ProductApi> {
  final String _productId;
  Product? _product;

  ProductCardModel(ProductApi productApi, this._productId) : super(productApi);

  Product? get product => _product;

  @override
  Future<void> loadData() async {
    try {
      setLoading(true);
      _product = await api.getProductDetails(_productId.toString());
    } catch (e) {
      setError('Error: $e');
    } finally {
      setLoading(false);
    }
  }
}