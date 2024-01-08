import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/category_grid/view/category_list_model.dart';
import 'package:shop/features/category_grid/widgets/widgets.dart';
import 'package:shop/repositories/shop_app/api/category_api.dart';
import 'package:shop/router/router.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key});
  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  final CategoryListModel _categoryListModel = CategoryListModel();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final categoryApi = Provider.of<CategoryApi>(context, listen: false);
    await _categoryListModel.loadCategories(categoryApi);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: const Text('КАТЕГОРИИ'),
        ),

        // TODO: ListenableBuilder
        body: ChangeNotifierProvider.value(
          value: _categoryListModel,
          child: Consumer<CategoryListModel>(
            builder: (context, categoryListModel, child) {
              if (categoryListModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoryListModel.error.isNotEmpty) {
                return Center(
                    child: Text(
                        'No categories available. ${categoryListModel.error}'));
              } else if (categoryListModel.categories.isEmpty) {
                return const Center(child: Text('No categories available.'));
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: categoryListModel.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryListModel.categories[index];
                    return CategoryGridPageTile(
                      category: category,
                      onTap: () {
                        Navigator.of(context)
                            .push(AppRoutes.productList(category));
                      },
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
