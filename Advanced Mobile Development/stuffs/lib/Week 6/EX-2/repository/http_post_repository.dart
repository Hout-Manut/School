import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import 'post_repository.dart';

class HttpPostRepository extends PostRepository {
  static const _endpoint = 'https://jsonplaceholder.typicode.com/posts';

  @override
  Future<Post> getPost(int postId) {
    return Future.delayed(Duration(seconds: 5), () {
      if (postId != 25) {
        throw Exception("No post found");
      }
      return Post(
        id: 25,
        title: 'Who is the best',
        description: 'teacher ronan',
      );
    });
  }

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch posts');
    }

    List<dynamic> body = jsonDecode(response.body);
    return List.generate(
      body.length,
      (index) => fromJson(body[index]),
    );
  }

  Post fromJson(Map<String, dynamic> json) {
    assert(json['id'] is int);
    assert(json['title'] is String);
    assert(json['body'] is String);

    return Post(
      id: json['id'],
      title: json['title'],
      description: json['body'],
    );
  }
}
