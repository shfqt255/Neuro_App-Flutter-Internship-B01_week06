import 'package:crud_api_app/API_Handling/api_service.dart';
import 'package:crud_api_app/Model/model.dart';
import 'package:flutter/foundation.dart';

class PostProvider extends ChangeNotifier {
  final ApiService api = ApiService();
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get post => _posts;
  bool get isLoading => _isLoading;

  Future<void> fetchPost() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await api.fetchPosts();
    } catch (e) {
      throw Exception('Error: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> createPosts(Post post) async {
    try {
      final newpost = await api.createPost(post);
      _posts.insert(0, newpost);
      notifyListeners();
    } catch (e) {
      throw Exception('Error $e');
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      final UpdatePost = await api.updatePost(post);
      int index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = UpdatePost;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deletePost(String id) async {
    try {
      await api.deletePost(id);
      _posts.removeWhere((post) => post.id == id);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
