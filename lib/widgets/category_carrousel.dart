import 'package:flutter/material.dart';
import 'package:meseros_app/models/category_model.dart';
import 'package:meseros_app/providers/product_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class CategoryCarrousel extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryCarrousel({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      // color: Colors.amber,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (_, int i) {
          return _CategoryCard(categories[i]);
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const _CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final CategoryModel? selectedCategory = productProvider.selectedCategory;
    return GestureDetector(
      onTap: () => productProvider.selectedCategory = category,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        width: 140,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color:
              selectedCategory != null && selectedCategory.id == category.id
                  ? AppTheme.primaryColor
                  : const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Center(
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color:
                  selectedCategory != null && selectedCategory.id == category.id
                      ? Colors.white
                      : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
