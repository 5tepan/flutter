import 'package:flutter/cupertino.dart';
import 'package:shop/core/model/base_data_model.dart';
import 'package:shop/product/model/api/product_api.dart';
import 'package:shop/product/model/entities/product.dart';

class ProductListModel extends BaseModel<ProductApi> {
  final String _categoryId;
  List<Product> _products = [];
  int _offset = 0;
  bool _hasMoreData = true;
  ScrollController _scrollController = ScrollController();

  ProductListModel(ProductApi productApi, this._categoryId) : super(productApi) {
    _scrollController.addListener(_scrollListener);
  }

  List<Product> get products => _products;
  bool get hasMoreData => _hasMoreData;
  ScrollController get scrollController => _scrollController;

  @override
  Future<void> loadData() async {
    if (loading || !_hasMoreData) {
      return;
    }

    try {
      setLoading(true);
      final newData = await api.getProductList(_categoryId, _offset.toString());
      if (newData.isNotEmpty) {
        _products.addAll(newData);
        _offset += newData.length;
        notifyListeners();
      } else {
        _hasMoreData = false;
      }
    } catch (e) {
      setError('Error: $e');
    } finally {
      setLoading(false);
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      loadData();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}