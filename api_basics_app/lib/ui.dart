import 'package:flutter/material.dart';
import 'api_fetch.dart';
import 'package:api_basics_app/model.dart';

class PostsPage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Basics App"),
        backgroundColor: Colors.lightBlue,
        foregroundColor:Colors.white
      ),
      body: FutureBuilder<List<Post>>(
        future: apiService.fetchPosts(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (snapshot.hasData) {
            final posts = snapshot.data!;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  color: Colors.amber,
                  child: ListTile(
                    title: Text(
                      posts[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(posts[index].body),
                  ),
                );
              },
            );
          }

          return Center(child: Text("Data is not Found!!!"));
        },
      ),
    );
  }
}