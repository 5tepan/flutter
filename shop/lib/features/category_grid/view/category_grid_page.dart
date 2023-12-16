import 'package:flutter/material.dart';
import 'package:shop/features/category_grid/widgets/widgets.dart';
import 'package:shop/repositories/shop_app/models/category.dart';
import 'package:shop/shop_app.dart';

class CategoryGridPage extends StatefulWidget {
  const CategoryGridPage({super.key});
  @override
  State<CategoryGridPage> createState() => _CategoryGridPageState();
}

class _CategoryGridPageState extends State<CategoryGridPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: const Text('КАТЕГОРИИ'),
      ),
      body: FutureBuilder<List<Category>>(
        future: ShopApp.getCategoryApi().getCategoryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No categories available.'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final category = snapshot.data![index];
                return CategoryGridPageTile(category: category);
              },
            );
          }
        },
      ),
    );
  }
}

