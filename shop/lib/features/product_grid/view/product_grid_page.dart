import 'package:flutter/material.dart';
import 'package:shop/features/product_grid/widgets/product_grid_page_tile.dart';
import 'package:shop/repositories/shop_app/models/category.dart';
import 'package:shop/repositories/shop_app/models/product.dart';
import 'package:shop/shop_app.dart';


class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key});

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  Category? category;
  late ScrollController _scrollController;
  late List<Product> _products;
  bool _loading = false;
  int _offset = 0;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _products = [];
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
    if (_loading || category == null || !_hasMoreData) {
      return;
    }

    setState(() {
      _loading = true;
    });

    final List<Product> newData = await ShopApp
        .getProductApi()
        .getProductList(
        category!.categoryId.toString(),
        _offset
    );

    if (newData != null && newData.isNotEmpty) {
      setState(() {
        _products.addAll(newData);
        _offset += 10;
        _loading = false;
      });
    } else {
      setState(() {
        _hasMoreData = false;
        _loading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Category, 'You must provide Category args');
    category = args as Category;
    _offset = 0;
    _loadData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(category?.title ?? '...'),
          backgroundColor: theme.colorScheme.inversePrimary,
        ),
        body: ListView.separated(
          controller: _scrollController,
          itemCount: _loading ? _products.length + 1 : _products.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            if (index < _products.length) {
              final product = _products[index];
              return ProductGridPageTile(product: product);
            } else if (_loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          },
        ),
    );
  }
}
