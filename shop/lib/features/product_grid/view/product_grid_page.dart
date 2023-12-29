import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/product_grid/view/product_list_model.dart';
import 'package:shop/features/product_grid/widgets/product_grid_page_tile.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';
import 'package:shop/repositories/shop_app/models/category.dart';
import 'package:shop/router/router.dart';

class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key, required this.category});

  final Category category;

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

// TODO: Сделать базовый класс для страниц. Функиции базового класса: объявление модели, построение scaffold и общих состояний экрана (ошибка и загрузка), базовая бизнес-логика
class _ProductGridPageState extends State<ProductGridPage> {
  final ScrollController _scrollController = ScrollController();
  final ProductListModel _productListModel = ProductListModel();

  @override
  void initState() {
    super.initState();
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

  Future<void> _loadData() async {
    final productApi = Provider.of<ProductApi>(context, listen: false);
    // TOD: API и категорию передавать в конструкторе ProductListModel| Для доступа к context и widget использовать late
    await _productListModel.loadProducts(
        productApi, widget.category.categoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: ChangeNotifierProvider.value(
        value: _productListModel,
        child: Consumer<ProductListModel>(
          builder: (context, productListModel, child) {
            // TODO: Добавить состояние ошибки и загрузки первой партии
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
                      Navigator.of(context)
                          .push(AppRoutes.productPage(product.productId));
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
