import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/page/base_page.dart';
import 'package:shop/product/view/product_image_slider.dart';
import 'package:shop/product/model/product_card_model.dart';
import 'package:shop/product/model/api/product_api.dart';

class ProductCardPage extends BasePage<ProductCardModel> {
  final int productId;

  const ProductCardPage({super.key, required this.productId});

  @override
  ProductCardModel createProvider(BuildContext context) {
    return ProductCardModel(
      Provider.of<ProductApi>(context, listen: false),
      productId.toString(),
    );
  }

  @override
  Widget buildBody(BuildContext context, ProductCardModel model) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
            child: Text(
              model.product!.title ?? '...',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductImageSlider(product: model.product!),
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
                  TextSpan(text: '${model.product!.price.toString()} руб'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 20.0, 0),
            child: ElevatedButton(
              onPressed: model.product!.isAvailableForSale == false
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
                model.product!.productDescription != ''
                    ? model.product!.productDescription
                    : 'Описание отсутствует...',
                style: theme.textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildAppBarTitle() {
    return const Text('');
  }
}
