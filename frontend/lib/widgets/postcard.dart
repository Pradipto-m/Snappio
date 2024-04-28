import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:snappio/services/posts_service.dart';

class PostCard extends StatefulWidget {
  final String id;
  final String user;
  final String imageUrl;
  final String caption;
  final String date;
  final int likes;
  final bool loved;

  const PostCard({
    super.key,
    required this.id,
    required this.user,
    required this.imageUrl,
    required this.caption,
    required this.date,
    required this.likes,
    required this.loved,
  });
  

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  late String date =
    DateFormat.yMd().format(DateTime.now()) ==
    DateFormat.yMd().format(DateTime.parse(widget.date))
      ? "Today"
      : DateFormat.yMMMd("en_US").format(DateTime.parse(widget.date));

  Future<bool> lovePost (bool loved) async {
    final PostsService postsService = PostsService();
    final res = await postsService.lovePost(context, widget.id);
    return loved ? !res : res;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        const SizedBox(height: 9),
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png'),
            radius: 19,),
          title: Text(widget.user, style: Theme.of(context).textTheme.bodyMedium),
          trailing: Text(date, style: Theme.of(context).textTheme.bodySmall),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
        )),
        Container(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Expanded(
              child: Text(widget.caption, style: Theme.of(context).textTheme.bodySmall)
            ),
            LikeButton(
              padding: const EdgeInsets.only(left: 10),
              size: 30,
              circleColor: CircleColor(
                start: Colors.red.shade100,
                end: Colors.red.shade400
              ),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.red.shade400,
                dotSecondaryColor: Colors.red.shade400
              ),
              isLiked: widget.loved,
              onTap: (bool isLiked) => lovePost(isLiked),
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? Ionicons.heart : Ionicons.heart_outline,
                  color: isLiked ? Colors.red[400] : Theme.of(context).iconTheme.color,
                  size: 30,
                );
              },
              likeCount: widget.likes,
              animationDuration: const Duration(milliseconds: 1250),
              likeCountAnimationDuration: const Duration(milliseconds: 1200),
            ),
          ]),
        ),
      ]),
    );
  }
}
