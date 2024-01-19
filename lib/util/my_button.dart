// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

@immutable
class MyButton extends StatelessWidget {
  final String name;
  VoidCallback onPressed;
  MyButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).colorScheme.primary,
      child: Text(name),
    );
  }
}
