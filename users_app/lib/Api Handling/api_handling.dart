import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:users_app/Model/user_model.dart';

class ApiHandling {
  final url = 'https://699e719778dda56d396a4177.mockapi.io/Api_v1/post';

  Future<List<UserModel>> fetchUsers({int page = 1, int limit = 5}) async {
    final response = await http.get(Uri.parse('$url?page=$page&limit=$limit'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data ');
    }
  }

  Future<UserModel> addUser(UserModel User) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(User.toJson()),
    );
    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse('$url/${user.id}'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse("$url/$id"));
    if (response.statusCode != 200) {
      throw Exception("Failed to delete user");
    }
  }
}
