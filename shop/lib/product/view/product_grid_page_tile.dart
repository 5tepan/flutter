import 'package:flutter/material.dart';
import 'package:shop/core/view/Image_widget.dart';
import 'package:shop/product/model/entities/product.dart';

class ProductGridPageTile extends StatelessWidget {
  const ProductGridPageTile(
      {super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: ImageWidget(imageUrl: product.imageUrl),
      title: Text(
        product.title ?? '',
        style: theme.textTheme.bodyMedium,
      ),
      onTap: onTap,
    );
  }
}
