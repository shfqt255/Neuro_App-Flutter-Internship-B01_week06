import 'package:crud_api_app/API_Handling/api_service.dart';
import 'package:crud_api_app/Model/model.dart';
import 'package:crud_api_app/Provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PostFormPage extends StatefulWidget {
  final Post? post;

   const  PostFormPage({super.key, this.post});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.post?.title ?? '');
    bodyController =
        TextEditingController(text: widget.post?.body ?? '');
  }

 void submit() async {
  if (_formKey.currentState!.validate()) {
    final provider = context.read<PostProvider>();

    try {
      if (widget.post == null) {
        await provider.createPosts(
          Post(
            title: titleController.text,
            body: bodyController.text,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Post Created")),
        );
      } else {
        await provider.updatePost(
          Post(
            id: widget.post!.id,
            title: titleController.text,
            body: bodyController.text,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Post Updated")),
        );
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Operation Failed")),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null
            ? "Create Post"
            : "Edit Post"),
      ),
      body: Padding(
        padding:   EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration:
                      InputDecoration(labelText: "Title"),
                validator: (value) =>
                    value!.isEmpty ? "Enter title" : null,
              ),
                SizedBox(height: 20),
              TextFormField(
                controller: bodyController,
                decoration:
                      InputDecoration(labelText: "Body"),
                validator: (value) =>
                    value!.isEmpty ? "Enter body" : null,
              ),
                SizedBox(height: 20),
              ElevatedButton(
                onPressed: submit,
                child:   Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}