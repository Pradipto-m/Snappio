import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';

class PostCard extends StatefulWidget {
  final String user;
  final String imageUrl;
  final String date;
  final String caption;

  const PostCard({
    super.key,
    required this.user,
    required this.imageUrl,
    required this.date,
    required this.caption
  });
  

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late String date =
    DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.date)) ==
      DateFormat("yyyy-MM-dd").format(DateTime.timestamp())
        ? "Today"
        : DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.date));

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png')),
          title: Text(widget.user),
          trailing: Text(date),
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
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Expanded(
              child: Text(widget.caption)
            ),
            LikeButton(
              size: 32,
              circleColor: CircleColor(
                start: Colors.red.shade100,
                end: Colors.red.shade400
              ),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.red.shade400,
                dotSecondaryColor: Colors.red.shade400
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                  size: 32,
                );
              },
              likeCount: 150,
              animationDuration: const Duration(milliseconds: 1250),
            ),
          ]),
        ),
      ]),
    );
  }
}
