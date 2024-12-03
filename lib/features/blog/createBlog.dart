import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellness/constants/urlApi.dart';

import '../../constants/Sqlite/sqliteDBHelper.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File? _image;
  final picker = ImagePicker();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final contentController = TextEditingController();
  final categoryIdController = TextEditingController();  // Optional: for category

  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Get.snackbar("Hey", "No image picked!!");
      }
    });
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }



  Future<void> postBlog() async {
    // Validate input fields
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        contentController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required!");
      return;
    }

    const createPost1 = UrlApi.urlCreatePost; // API endpoint
    var uri = Uri.parse(createPost1);
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    request.fields['title'] = titleController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['content'] = contentController.text;

    // Add categoryId if provided
    if (categoryIdController.text.isNotEmpty) {
      request.fields['categoryId'] = categoryIdController.text;
    }

    // Add image file if selected
    if (_image != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // API's image field name
          _image!.path,
        ),
      );
    }

    try {
      // Retrieve token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken'); // Ensure the key matches your app

      if (token == null) {
        Get.snackbar("Error", "Authorization token is missing. Please log in again.");
        return;
      }

      // Add Authorization header
      request.headers['Authorization'] = 'Bearer $token';

      // Send the request
      var response = await request.send();
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Blog posted successfully!");

        // Clear fields after success
        titleController.clear();
        descriptionController.clear();
        contentController.clear();
        setState(() {
          _image = null;
        });
      } else {
        Get.snackbar("Error", "Failed to post blog. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Blog")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: getImageFromGallery,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minWidth: _image == null ? 100 : 200,
                          minHeight: _image == null ? 100 : 200,
                          maxHeight: _image == null ? 100 : 300,
                          maxWidth: _image == null
                              ? 100
                              : MediaQuery.of(context).size.height / 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!.absolute,
                            fit: BoxFit.cover,
                          ),
                        )
                            : const Center(
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      if (_image != null)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: removeImage,
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: categoryIdController,
                decoration: const InputDecoration(
                  labelText: 'Category ID (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: postBlog,
              child: const Text("Post Blog"),
            ),
          ],
        ),
      ),
    );
  }
}
