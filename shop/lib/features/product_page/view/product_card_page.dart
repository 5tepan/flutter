import 'package:flutter/material.dart';
import 'package:shop/features/product_page/widgets/product_image_slider.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

class ProductCardPage extends StatefulWidget {
  const ProductCardPage({super.key});

  @override
  State<ProductCardPage> createState() => _ProductCardPageState();
}

class _ProductCardPageState extends State<ProductCardPage> {
  Product? product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is Product, 'You must provide Product args');
    product = args as Product;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.purple),
      ),
      body: SingleChildScrollView(
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
                  TextSpan(text: '${product!.price.toString()} руб'),
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 20.0, 0),
              child: ElevatedButton(
                onPressed: product?.isAvailableForSale == false
                    ? null
                    : () {},
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
                product!.productDescription != '' ?  product!.productDescription : 'Описание отсутствует...',
                style: theme.textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
