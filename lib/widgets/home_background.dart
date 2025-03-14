import 'package:flutter/material.dart';
import 'package:meseros_app/theme/app_theme.dart';

class HomeBackground extends StatelessWidget {
  final Widget child;
  const HomeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white24,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [_BackgroundBox(size: size), child],
      ),
    );
  }
}

class _BackgroundBox extends StatelessWidget {
  const _BackgroundBox({required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.25,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            const Color.fromRGBO(179, 57, 57, 0.88),
          ],
        ),
      ),
    );
  }
}
