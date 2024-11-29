import 'package:flutter/material.dart';
import 'package:location_flutter_app/app/shared/app/ui/custom_bottom_navigation_bar.dart';

class NavigatorScreen extends StatelessWidget {
  final Widget child;

  const NavigatorScreen({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
