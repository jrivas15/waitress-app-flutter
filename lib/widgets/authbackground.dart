import 'package:flutter/material.dart';
import 'package:meseros_app/theme/app_theme.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white24,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [_BackgroundBox(size: size), _Icon(), child],
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 60),
        child: Icon(Icons.person_pin, size: 100, color: Colors.white),
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
      height: size.height * 0.45,
      decoration: BoxDecoration(
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
