import 'dart:convert';
import 'package:crud_api_app/Model/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = "https://69a1e7902e82ee536fa28d84.mockapi.io/Crud";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$url/${post.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future deletePost(String id) async {
    final response = await http.delete(Uri.parse("$url/$id"));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete Post');
    }
  }
}
