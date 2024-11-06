import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_final/constants/urlApi.dart';
import 'package:sleep_final/screens/userGuideScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreateBlogController extends GetxController {
  var postTitleController = TextEditingController().obs;
  var postDescriptionController = TextEditingController().obs;
  var postContentController = TextEditingController().obs;

  var postCategoryController = TextEditingController().obs;
  // image retrieving controller here:

  var isLoading = false.obs;

  @override
  void onClose() {
    postTitleController.value.dispose();
    postDescriptionController.value.dispose();
    postContentController.value.dispose();
    postCategoryController.value.dispose();
    // image here

    super.onClose();
  }

  void clearForm() {
    postTitleController.value.dispose();
    postDescriptionController.value.clear();
    postContentController.value.clear();
    postCategoryController.value.clear();
    // image here:

  }

  Future<void> logInButton() async {
    isLoading.value = true;
    const createPostUrl = UrlApi.urlCreatePost;

    try {
      final response = await http.post(
        Uri.parse(createPostUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'title': postTitleController.value.text,
          'description': postDescriptionController.value.text,
          'content' :  postContentController,
          'categoryId' : postCategoryController,
          // handle image here
          'image':  "" ,

        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        final accessToken = responseData['accessToken'];
        final tokenType = responseData['tokenType'];


      } else {
        Get.snackbar('Error', 'Creating Post');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      clearForm();
    }
  }
}
