import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/category/model/category_list_model.dart';
import 'package:shop/category/view/category_grid_page_tile.dart';
import 'package:shop/category/model/api/category_api.dart';
import 'package:shop/core/page/base_page.dart';
import 'package:shop/router/router.dart';

class CategoryGridPage extends BasePage<CategoryListModel> {
  const CategoryGridPage({super.key});

  @override
  CategoryListModel createProvider(BuildContext context) {
    return CategoryListModel(
      Provider.of<CategoryApi>(context, listen: false),
    );
  }

  @override
  Widget buildBody(BuildContext context, CategoryListModel model) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: model.categories.length,
      itemBuilder: (context, index) {
        final category = model.categories[index];
        return CategoryGridPageTile(
          category: category,
          onTap: () {
            Navigator.of(context).push(AppRoutes.productList(category));
          },
        );
      },
    );
  }

  @override
  Widget buildAppBarTitle() {
    return const Text('КАТЕГОРИИ');
  }
}
