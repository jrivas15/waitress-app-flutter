import 'package:flutter/material.dart';
import 'package:meseros_app/models/category_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/providers/order_provider.dart';
import 'package:meseros_app/providers/product_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:meseros_app/utils/utils.dart';
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
            child: GridView.count(
              mainAxisSpacing: 10,

              crossAxisCount: 3,
              children:
                  productProvider.products
                      .map(
                        (product) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            // vertical: 20,
                          ),
                          child: IntrinsicHeight(
                            child: _ProductCard(product: product),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        print(product.name);

        orderProvider.addOrderItem(product);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 130,
          height: 130,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [AppTheme.boxShadowCards],
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                color: const Color.fromARGB(96, 152, 152, 152),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  product.name,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '\$ ${formatNumber(product.price)}',
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
    );
  }
}
