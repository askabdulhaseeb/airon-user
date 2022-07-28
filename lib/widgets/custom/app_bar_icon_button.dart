import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    required this.onTap,
    required this.icon,
    this.padding,
    Key? key,
  }) : super(key: key);
  final VoidCallback onTap;
  final IconData icon;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(child: Icon(icon)),
          ),
        ),
      ),
    );
  }
}
