import 'package:flutter/material.dart';
import 'package:users_app/Api%20Handling/api_handling.dart';
import 'package:users_app/Model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final ApiHandling api = ApiHandling();

  List<UserModel> users = [];
  bool isLoading = false;
  String? error;

  int page = 1;
  final int limit = 5;
  bool hasMore = true;

  // Fetch users
  Future<void> fetchUsers({bool refresh = false}) async {
    if (refresh) {
      page = 1;
      users.clear();
      hasMore = true;
    }
    if (!hasMore) return;

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final newUsers = await api.fetchUsers(page: page, limit: limit);

      if (newUsers.isEmpty) {
        hasMore = false;
      } else {
        users.addAll(newUsers);
        page++;
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Search
  String _searchQuery = '';

  List<UserModel> get filteredUsers {
    if (_searchQuery.isEmpty) return users;
    return users
        .where((u) => u.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Add
  Future<void> add(UserModel user) async {
    try {
      final newUser = await api.addUser(user);
      users.insert(0, newUser);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // Update
  Future<void> update(UserModel user) async {
    try {
      final updatedUser = await api.updateUser(user);
      final index = users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        users[index] = updatedUser;
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // Delete
  Future<void> delete(String id) async {
    try {
      await api.deleteUser(id);
      users.removeWhere((u) => u.id == id);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
