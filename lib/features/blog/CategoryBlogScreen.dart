import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/urlApi.dart';
import 'BlogFullView.dart';  // Import the BlogFullView screen for navigation

class CategoryBlogScreen extends StatefulWidget {
  final int categoryId;

  // Constructor to receive the categoryId
  const CategoryBlogScreen({super.key, required this.categoryId});

  @override
  _CategoryBlogScreenState createState() => _CategoryBlogScreenState();
}

class _CategoryBlogScreenState extends State<CategoryBlogScreen> {
  List blogs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBlogs(widget.categoryId); // Fetch blogs based on the category ID passed
  }

  // Fetch blogs from the API based on category ID
  Future<void> fetchBlogs(int categoryId) async {
    final blogCategoryUrl = '${UrlApi.getPostsByCategoryId}/$categoryId';
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(blogCategoryUrl));

      if (response.statusCode == 200) {
        setState(() {
          blogs = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs in Category'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : blogs.isEmpty
          ? const Center(child: Text('No blogs available for this category.'))
          : ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return BlogCard(blog: blog); // Create a widget to display each blog item
        },
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final Map<String, dynamic> blog;

  const BlogCard({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the detailed blog view on tap
        // Navigator.push(
        //   // context,
          // MaterialPageRoute(
          //   // builder: (context) => BlogFullView(blog: blog),
        //   // ),
        // );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text section
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog['title'] ?? 'Untitled',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF193238),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        blog['description'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  blog['imageUrl'] ??
                      'https://via.placeholder.com/100', // Provide a default image if URL is empty
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
