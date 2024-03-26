import 'package:flutter/material.dart';

class UploadPosts extends StatelessWidget {
  static const String routeName = '/upload';
  const UploadPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Upload Posts',
        style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
