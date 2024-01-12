import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/page/base_page.dart';
import 'package:shop/product/view/product_grid_page_tile.dart';
import 'package:shop/product/model/product_list_model.dart';
import 'package:shop/product/model/api/product_api.dart';
import 'package:shop/category/model/entities/category.dart';
import 'package:shop/router/router.dart';

class ProductGridPage extends BasePage<ProductListModel> {
  const ProductGridPage({super.key, required this.category});

  final Category category;

  @override
  ProductListModel createProvider(BuildContext context) {
    return ProductListModel(
      Provider.of<ProductApi>(context, listen: false),
      category.categoryId.toString(),
    );
  }

  @override
  Widget buildBody(BuildContext context, ProductListModel model) {

    return ListView.separated(
      controller: model.scrollController,
      itemCount: model.loading
          ? model.products.length + 1
          : model.products.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        if (index < model.products.length) {
          final product = model.products[index];
          return ProductGridPageTile(
            product: product,
            onTap: () {
              Navigator.of(context).push(AppRoutes.productPage(product.productId));
            },
          );
        } else if (model.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget buildAppBarTitle() {
    return Text(category.title);
  }
}

// TODO: Сделать базовый класс для страниц. Функиции базового класса: объявление модели, построение scaffold и общих состояний экрана (ошибка и загрузка), базовая бизнес-логика
// TODO: API и категорию передавать в конструкторе ProductListModel| Для доступа к context и widget использовать late ##
// TODO: Добавить состояние ошибки и загрузки первой партии ##
