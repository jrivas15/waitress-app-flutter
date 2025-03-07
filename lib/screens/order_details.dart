import 'package:flutter/material.dart';
import 'package:meseros_app/theme/app_theme.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text('Cuenta', style: AppTheme.titleStyle),
          // CustomCarrousel(),
          Expanded(
            child: Container(width: double.infinity, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
