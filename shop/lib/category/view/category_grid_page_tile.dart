import 'package:flutter/material.dart';
import 'package:shop/category/model/entities/category.dart';
import 'package:shop/core/view/Image_widget.dart';

class CategoryGridPageTile extends StatelessWidget {
  const CategoryGridPageTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO: Вынести в отдельный виджет и переиспользовать в других местах ##
          ImageWidget(imageUrl: category.imageUrl),
          Text(category.title.toUpperCase(),
              style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
      onTap: onTap,
    );
  }
}
