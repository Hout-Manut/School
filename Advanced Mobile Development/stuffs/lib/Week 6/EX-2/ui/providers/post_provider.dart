import 'package:flutter/material.dart';

import '../../model/post.dart';
import '../../repository/post_repository.dart';
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _repository;

  AsyncValue<Post>? postValue;
  AsyncValue<List<Post>>? postsValue;

  PostProvider({required PostRepository repository}) : _repository = repository;

  void fetchPost(int postId) async {
    // 1-  Set loading state
    postValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2   Fetch the data
      Post post = await _repository.getPost(postId);

      // 3  Set success state
      postValue = AsyncValue.success(post);
    } catch (error) {
      // 4  Set error state
      postValue = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void fetchPosts() async {
    postsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Post> posts = await _repository.getPosts();

      if (posts.isEmpty) {
        postsValue = AsyncValue.empty();
      } else {
        postsValue = AsyncValue.success(posts);
      }
    } catch (error) {
      postsValue = AsyncValue.error(error);
    }

    notifyListeners();
  }
}
