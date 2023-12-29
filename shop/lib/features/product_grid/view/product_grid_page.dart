import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/product_grid/view/product_list_model.dart';
import 'package:shop/features/product_grid/widgets/product_grid_page_tile.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/repositories/shop_app/models/category.dart';
import 'package:shop/router/router.dart';

class ProductGridPage extends StatefulWidget {
  const ProductGridPage({
    super.key,
    required this.category
  });

  final Category category;

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  final ScrollController _scrollController = ScrollController();
  final ProductListModel _productListModel = ProductListModel();

  @override
  void initState() {
    super.initState();
    // TODO: _scrollController и _products можно инициализировать сразу при объявлении ##
    _loadData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadData();
    }
  }

  // TODO: Вынести загрузку данных в ProductListModel. ##
  // ProductListModel унаследовать от ChangeNotifier для обновления экрана
  // Основные и вспомогательные данные хранятся в ProductListModel, страница считывает их из модели и отображает интерфейс в зависимости от этих данных.
  // Страница передает команды в модель, такие как: загрузка данных, загрузка новой порции данных, перезагрузка данных и прочее. Набор команд зависит от объекта и экрана где модель используется.
  // По аналогии добавить модели для других страниц
  Future<void> _loadData() async {
    final productApi = Provider.of<ProductApi>(context, listen: false);
    await _productListModel.loadProducts(productApi, widget.category.categoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title ?? '...'),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: ChangeNotifierProvider.value(
        value: _productListModel,
        child: Consumer<ProductListModel>(
          builder: (context, productListModel, child) {
            return ListView.separated(
              controller: _scrollController,
              itemCount: productListModel.loading
                  ? productListModel.products.length + 1
                  : productListModel.products.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                if (index < productListModel.products.length) {
                  final product = productListModel.products[index];
                  return ProductGridPageTile(
                    product: product,
                    onTap: () {
                      Navigator.of(context).push(AppRoutes.productPage(product.productId));
                    },
                  );
                } else if (productListModel.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
