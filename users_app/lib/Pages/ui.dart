import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/Model/user_model.dart';
import 'package:users_app/Provider/api_provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// Fetch users once when page loads
    Future.microtask(() =>
        Provider.of<UserProvider>(context, listen: false).fetchUsers());
  }

  void showUserDialog(BuildContext context, UserProvider provider,
      {UserModel? user}) {
    final nameController = TextEditingController(text: user?.name ?? "");
    final emailController = TextEditingController(text: user?.email ?? "");

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(user == null ? "Add User" : "Edit User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child:  Text("Cancel")),
            TextButton(
              onPressed: () {
                if (user == null) {
                  provider.add(UserModel(
                    id: '',
                    name: nameController.text,
                    email: emailController.text,
                  ));
                } else {
                  provider.update(UserModel(
                    id: user.id,
                    name: nameController.text,
                    email: emailController.text,
                  ));
                }
                Navigator.pop(context);
              },
              child:Text("Submit"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        final filteredUsers = provider.filteredUsers;

        return Scaffold(
          appBar: AppBar(
            title:  Text("Users App"),
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
          ),

          body: provider.isLoading && provider.users.isEmpty
              ?  Center(child: CircularProgressIndicator())
              : provider.error != null
                  ? Center(child: Text("Error: ${provider.error}"))
                  : RefreshIndicator(
                      onRefresh: () => provider.fetchUsers(refresh: true),
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                labelText: "Search",
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onChanged: (value) {
                                provider.search(value);
                              },
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: filteredUsers.length +
                                  ((provider.hasMore &&
                                          searchController.text.isEmpty)
                                      ? 1
                                      : 0),
                              itemBuilder: (context, index) {
                                if (index < filteredUsers.length) {
                                  final user = filteredUsers[index];

                                  return Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: ListTile(
                                      title: Text(user.name),
                                      subtitle: Text(user.email),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit,
                                                color: Colors.lightBlue),
                                            onPressed: () => showUserDialog(
                                                context, provider,
                                                user: user),
                                          ),
                                          IconButton(
                                            icon:  Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () =>
                                                provider.delete(user.id),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: provider.isLoading
                                            ? null
                                            : () => provider.fetchUsers(),
                                        child: provider.isLoading
                                            ?  CircularProgressIndicator()
                                            :  Text("Load More"),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showUserDialog(context, provider),
            child:  Icon(Icons.add, color: Colors.lightBlue,),
          ),
        );
      },
    );
  }
}