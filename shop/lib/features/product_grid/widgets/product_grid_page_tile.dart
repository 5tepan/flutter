import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/repositories/shop_app/models/product.dart';

class ProductGridPageTile extends StatelessWidget {
  const ProductGridPageTile({
    super.key,
    required this.product,
    required this.onTap
  });

  final Product product;
  final VoidCallback onTap;

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
      // TODO: Навигацию вынести на страницу. ##
      // Виджет может определить действие пользователя и дать отклик (визуальный эффект), но обрабатывать действие - задача уровня страницы.
      // Виджеты не содержат логику приложения.
      // По аналогии остальные виджеты
      onTap: onTap,
    );
  }
}
