import 'package:flutter/material.dart';

class SnapsPage extends StatefulWidget {
  const SnapsPage({super.key});

  @override
  State<SnapsPage> createState() => _SnapsPageState();
}

class _SnapsPageState extends State<SnapsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Snaps Feature Page',
        style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
