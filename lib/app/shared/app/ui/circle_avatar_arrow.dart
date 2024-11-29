import 'package:flutter/material.dart';

class CircleArrowWidget extends StatelessWidget {
  const CircleArrowWidget({
    required this.colorBackground,
    required this.icon,
    super.key,
  });

  final Color colorBackground;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: colorBackground,
          child: Icon(icon),
        ),
      ],
    );
  }
}
