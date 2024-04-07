import 'package:flutter/material.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.withOpacity(0.4),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 20,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ]),
          Container(
            height: 250,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
          Row(children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 20,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.withOpacity(0.4),
            ),
          ]),
        ],
      ),
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}