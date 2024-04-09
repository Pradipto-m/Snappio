import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:snappio/models/posts_model.dart';
import 'package:snappio/providers/posts_provider.dart';
import 'package:snappio/services/posts_service.dart';
import 'package:snappio/widgets/postcard.dart';
import 'package:snappio/widgets/shimmer_skeleton.dart';

class PostsFeed extends ConsumerStatefulWidget {
  const PostsFeed({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsFeedState();
}

class _PostsFeedState extends ConsumerState<PostsFeed> {

  @override
  void initState() {
    super.initState();
    _onLoad();
  }

  static bool loader = false;

  Future<void> _onLoad() async {
    setState(() => loader = true);
    Future.delayed(const Duration(seconds: 2));
    final postsService = PostsService();
    await postsService.fetchAllPosts(context, ref);
    setState(() => loader = false);
  }
  

  @override
  Widget build(BuildContext context) {

    final List<PostsModel> posts = ref.watch(postsProvider.notifier).getPosts();

    return Scaffold(
      appBar: AppBar(
        title: Text("Snappio", style: Theme.of(context).textTheme.labelLarge),
        centerTitle: true,
        actions: [
        IconButton(
          icon: const Icon(Ionicons.add),
          onPressed: () {},
        )
      ]),
      body: RefreshIndicator(
        onRefresh: () {
          return _onLoad();
        },
        child: loader ? 
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(7),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => const ShimmerCard()
          ) :
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(7),
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (context, index) => PostCard(
              id: posts[index].id,
              user: posts[index].postedBy,
              imageUrl: posts[index].file,
              caption: posts[index].content,
              date: posts[index].timestamp,
              likes: posts[index].likes,
              loved: posts[index].loved,
            )
          ),
      ),
    );
  }
}
