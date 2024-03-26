import 'package:flutter/material.dart';

class PostsFeed extends StatefulWidget {
  const PostsFeed({super.key});

  @override
  State<PostsFeed> createState() => _PostsFeedState();
}

class _PostsFeedState extends State<PostsFeed> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Posts Feed',
        style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
