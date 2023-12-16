import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/repositories/shop_app/models/category.dart';

class CategoryGridPageTile extends StatelessWidget {
  const CategoryGridPageTile({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            category.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return SvgPicture.asset(
                'assets/default_category.svg',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              );
            },
          ),
          Text(
            category.title.toUpperCase(),
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
            '/product_grid_page',
            arguments: category
        );
      },
    );
  }
}