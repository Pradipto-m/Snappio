import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PrivateChat extends StatefulWidget {
  final String userId;
  const PrivateChat({super.key, required this.userId});

  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId,
          style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Bubble(
                  margin: const BubbleEdges.only(top: 12),
                  padding: const BubbleEdges.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.centerRight,
                  nip: BubbleNip.rightTop,
                  radius: const Radius.circular(14),
                  color: Theme.of(context).cardColor,
                  child: Text('Hello, World! Hello, World! Hello, World! Hello, World! Hello, World! Hello, World!', style: Theme.of(context).textTheme.bodyMedium),
                );
              },
            )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).cardColor.withOpacity(0.6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).cardColor,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(Ionicons.send, size: 30),
                  ),
                ),
              ],
            ),
          )
        ]),
      )
    );
  }
}