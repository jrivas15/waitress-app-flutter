import 'package:flutter/material.dart';
import 'package:meseros_app/models/category_model.dart';
import 'package:meseros_app/providers/product_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/widgets/category_carrousel.dart';
import 'package:provider/provider.dart';

class SelectProducts extends StatelessWidget {
  const SelectProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<CategoryModel> categories = productProvider.categories;
    return Expanded(
      child: Column(
        children: [
          Text('Categorias', style: AppTheme.titleStyle),
          CategoryCarrousel(categories: categories),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.red,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 130,
                      height: 130,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            color: Colors.amber,
                            child: Text('Photo'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Almuerzo meridional',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  '\$ 9.50',
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
