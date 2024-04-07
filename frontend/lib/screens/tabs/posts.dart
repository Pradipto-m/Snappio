import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:snappio/widgets/postcard.dart';
import 'package:snappio/widgets/shimmer_skeleton.dart';

class PostsFeed extends ConsumerStatefulWidget {
  const PostsFeed({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsFeedState();
}

class _PostsFeedState extends ConsumerState<PostsFeed> {
  @override
  Widget build(BuildContext context) {

    bool? loader = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Snappio"),
        centerTitle: true,
        actions: [
        IconButton(
          icon: const Icon(Ionicons.add),
          onPressed: () {},
        )
      ]),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() => loader = true);
          return Future.delayed(const Duration(seconds: 2),
            () => setState(() => loader = true));
        },
        child: loader == true
          ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => const ShimmerCard(),
          )
          : loader == false
            ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(7),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => PostCard(
                user: 'Username',
                imageUrl: 'https://picsum.photos/300/300',
                date: DateTime.now().toString(),
                caption: 'This is my first post on Snappio ❤️',
              )
            )
            : const Center(
              child: Text("Oops Something went wrong!"),
            ),
      ),
    );
  }
}
