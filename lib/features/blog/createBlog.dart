import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getImageFromGallery();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 10, top: 5, bottom: 2),
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
          // Add other fields like title and description here
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
          ),
        ],
      ),
    );
  }
}
