import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

class ProductGridPageTile extends StatelessWidget {
  const ProductGridPageTile({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Image.network(
        product.imageUrl,
        width: 45,
        height: 45,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(
            'assets/default_product.svg',
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          );
        },
      ),
      title: Text(
        product.title ?? '',
        style: theme.textTheme.bodyMedium,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/product_page',
          arguments: product
        );
      },
    );
  }
}
