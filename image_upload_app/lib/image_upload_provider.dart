import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class ImageUploadProvider extends ChangeNotifier {
  File? _selectedImage;
  String? _uploadedImageUrl;
  double _progress = 0.0;
  bool _isUploading = false;
  String? _error;

  File? get selectedImage => _selectedImage;
  String? get uploadedImageUrl => _uploadedImageUrl;
  double get progress => _progress;
  bool get isUploading => _isUploading;
  String? get error => _error;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      File imageFile = File(picked.path);
      _selectedImage = await _compressImage(imageFile);
      notifyListeners();
    }
  }

  Future<File> _compressImage(File file) async {
    final bytes = await file.readAsBytes();
    img.Image? image = img.decodeImage(bytes);

    img.Image resized = img.copyResize(image!, width: 800);

    final compressedBytes = img.encodeJpg(resized, quality: 70);

    final compressedFile = File(file.path)..writeAsBytesSync(compressedBytes);

    return compressedFile;
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) return;

    _isUploading = true;
    _progress = 0.0;
    _error = null;
    notifyListeners();

    try {
      var uri = Uri.parse(
        "https://api.imgbb.com/1/upload?key=5190fcae6e67cd8cde999ac4999ddace",
      );

      var request = http.MultipartRequest('POST', uri);

      var bytes = await _selectedImage!.readAsBytes();

      var multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: "upload.jpg",
      );

      request.files.add(multipartFile);

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _uploadedImageUrl = data['data']['url'];
      } else {
        _error = "Upload Failed: ${response.statusCode}";
      }
    } catch (e) {
      _error = e.toString();
    }

    _isUploading = false;
    notifyListeners();
  }
}
