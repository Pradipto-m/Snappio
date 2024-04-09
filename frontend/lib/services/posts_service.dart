// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snappio/models/posts_model.dart';
import 'package:snappio/providers/posts_provider.dart';
import 'package:snappio/widgets/snackbar.dart';

class PostsService {

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.0.103:3000/api/v1',
  ));

  Future<void> fetchAllPosts(BuildContext context, WidgetRef ref) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth');

      final response = await _dio.get('/posts/all',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
      ));

      if (response.statusCode == 200) {

        final List<dynamic> postsJson = response.data;
        final List<PostsModel> postsList = postsJson.map(
          (post) => PostsModel.fromJson(post)).toList();
        ref.read(postsProvider.notifier).setPosts(postsList);

      } else {
        showSnackBar(context, 'Something went wrong from our side');
      }
    } catch (err) {
      log(err.toString());
      showSnackBar(context, 'Server Error!');
    }
  }

  Future<bool> lovePost (BuildContext context, String postId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth');

      final response = await _dio.put('/posts/react',
        data: {'postId': postId},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
      ));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      log(err.toString());
      showSnackBar(context, 'Server Error!');
      return false;
    }
  }
}
