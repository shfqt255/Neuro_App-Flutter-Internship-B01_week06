import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'image_upload_provider.dart';

class HomePage extends StatelessWidget {
   const  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ImageUploadProvider>();

    return Scaffold(
      appBar: AppBar(title:   Text("Image Upload App")),
      body: Padding(
        padding:   EdgeInsets.all(20),
        child: Column(
          children: [
            if (provider.selectedImage != null)
              Image.file(provider.selectedImage!, height: 200),

              SizedBox(height: 20),

            ElevatedButton(
              onPressed: provider.pickImage,
              child:   Text("Pick Image"),
            ),

              SizedBox(height: 20),

            ElevatedButton(
              onPressed: provider.uploadImage,
              child:   Text("Upload Image"),
            ),

              SizedBox(height: 20),

            if (provider.isUploading)
              Column(
                children: [
                  LinearProgressIndicator(value: provider.progress),
                    SizedBox(height: 10),
                  Text("${(provider.progress * 100).toStringAsFixed(0)}%"),
                ],
              ),

            if (provider.uploadedImageUrl != null)
              Column(
                children: [
                    SizedBox(height: 20),
                    Text("Uploaded Image:"),
                  Image.network(provider.uploadedImageUrl!, height: 200),
                ],
              ),

            if (provider.error != null)
              Text(provider.error!, style:   TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
