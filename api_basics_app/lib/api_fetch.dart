import 'dart:convert';
import 'package:api_basics_app/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}