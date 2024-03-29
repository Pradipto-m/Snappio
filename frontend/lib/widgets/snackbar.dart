import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: Theme.of(context).textTheme.displaySmall),
      duration: Durations.extralong1,
    )
  );
}
