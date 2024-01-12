import 'package:shop/core/model/base_data_model.dart';
import 'package:shop/category/model/api/category_api.dart';
import 'package:shop/category/model/entities/category.dart';

class CategoryListModel extends BaseModel<CategoryApi> {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoryListModel(CategoryApi categoryApi) : super(categoryApi);

  @override
  Future<void> loadData() async {
    try {
      setLoading(true);
      _categories = await api.getCategoryList();
    } catch (e) {
      setError('Error: $e');
    } finally {
      setLoading(false);
    }
  }
}