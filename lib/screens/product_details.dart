import 'package:flutter/material.dart';
import 'package:meseros_app/models/modifier_model.dart';
import 'package:meseros_app/models/product_model.dart';
import 'package:meseros_app/providers/order_provider.dart';
import 'package:meseros_app/providers/product_provider.dart';
import 'package:meseros_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    final size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    final listModifiers = productProvider.listModifiers;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _Image(size: size),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(product.name, style: AppTheme.titleStyle),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: double.infinity,
                    child: Text(
                      "Modificadores",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  _ModifiersOptions(listModifiers: listModifiers),
                  _TextArea(),
                  ElevatedButton(
                    onPressed: () {
                      final orderProvider = Provider.of<OrderProvider>(
                        context,
                        listen: false,
                      );
                      orderProvider.updateOrderItemModifiers(
                        product,
                        productProvider.currModifiers,
                        productProvider.currNote,
                      );
                      productProvider.resetProductDetails();
                      Navigator.pop(context);
                    },
                    child: Text('Guardar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: productProvider.currNote,
        maxLines: 2,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          productProvider.currNote = value;
        },
        decoration: InputDecoration(
          filled: true,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),

          hintText: 'Agregar una nota',
        ),
      ),
    );
  }
}

class _ModifiersOptions extends StatelessWidget {
  const _ModifiersOptions({required this.listModifiers});

  final List<ModifierModel> listModifiers;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final currModifiers = productProvider.currModifiers;
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children:
            listModifiers
                .map(
                  (ModifierModel modifier) => CheckboxListTile(
                    value:
                        currModifiers.isNotEmpty
                            ? productProvider.currModifiers.contains(modifier)
                            : false,
                    onChanged: (state) {
                      productProvider.addModifiersChecks(state!, modifier);
                    },
                    title: Text(modifier.name),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                )
                .toList(),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.35,
      color: Colors.grey,
    );
  }
}
