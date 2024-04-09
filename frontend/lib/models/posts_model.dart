class PostsModel {
  final String id;
  final String content;
  final String file;
  final String postedBy;
  final int likes;
  final bool loved;
  final String timestamp;

  PostsModel({
    required this.id,
    required this.content,
    required this.file,
    required this.postedBy,
    required this.likes,
    required this.loved,
    required this.timestamp,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) =>
    PostsModel(
      id: json["_id"],
      content: json["content"],
      file: json["file"],
      postedBy: json["postedBy"],
      likes: json["likes"],
      loved: json["loved"],
      timestamp: json["timestamp"],
    );
}
