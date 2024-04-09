import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio/models/posts_model.dart';

class PostsNotifier extends StateNotifier<List<PostsModel>> {
  PostsNotifier() : super([]);

  void setPosts(List<PostsModel> posts) {
    state = posts;
  }

  List<PostsModel> getPosts() {
    return state;
  }
}

final postsProvider =
StateNotifierProvider<PostsNotifier, List<PostsModel>>((ref) => 
  PostsNotifier()
);
