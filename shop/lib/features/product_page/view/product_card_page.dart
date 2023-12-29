import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/features/product_page/view/product_card_model.dart';
import 'package:shop/features/product_page/widgets/product_image_slider.dart';
import 'package:shop/repositories/shop_app/api/product_api.dart';

class ProductCardPage extends StatefulWidget {
  const ProductCardPage({
    super.key,
    required this.productId
  });

  final int productId;

  @override
  State<ProductCardPage> createState() => _ProductCardPageState();
}

class _ProductCardPageState extends State<ProductCardPage> {
  final ProductCardModel _productCardModel = ProductCardModel();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final productApi = Provider.of<ProductApi>(context, listen: false);
    await _productCardModel.loadProductDetails(productApi, widget.productId);
  }
  // TODO: На экран передается productId, сам Produсt загружается через API ##
  // Push-уведомление или DeepLink или список товаров может содержать ограниченную модель Product, которой будет не хватать для отображения деталей
  // Product? product;

    // TODO: Не использовать ModalRoute.of(context)?.settings.arguments для передачи параметров на страниц. ##
    // Это делает неявной структуру параметров страницы. Лучше передавать параметры на через параметры ProductCardPage
    // Другие страницы по аналогии.


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.purple),
      ),
      body: ChangeNotifierProvider.value(
        value: _productCardModel,
        child: Consumer<ProductCardModel>(
        builder: (context, productCardModel, child) {
          if (productCardModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productCardModel.error.isNotEmpty) {
            return const Center(child: Text('No product available.'));
          } else {
            final product = productCardModel.product;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                    child: Text(
                      product!.title ?? '...',
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductImageSlider(product: product),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text: 'Цена: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${product.price.toString()} руб'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 20.0, 0),
                    child: ElevatedButton(
                      onPressed: product.isAvailableForSale == false ? null : () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: Text(
                        'Купить',
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                    child: Text(
                      'Описание:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                    child: Center(
                      child: Text(
                        product.productDescription != ''
                            ? product.productDescription
                            : 'Описание отсутствует...',
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        )
      )
    );
  }
}
