import 'package:crud_api_app/Pages/form_page.dart';
import 'package:crud_api_app/Provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<PostProvider>().fetchPost());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD with Provider"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PostFormPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.post.length,
              itemBuilder: (context, index) {
                final post = provider.post[index];

                return Column(
                  children: [
                    ListTile(
                      tileColor: Colors.teal,
                      title: Text(
                        post.title,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        post.body,
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.deletePost(post.id ?? '');
                              provider.fetchPost();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Post Deleted")),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.white),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PostFormPage(post: post),
                                ),
                              );
                              provider.fetchPost();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                );
              },
            ),
    );
  }
}
