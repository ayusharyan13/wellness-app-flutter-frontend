import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_final/constants/urlApi.dart';
import 'BlogFullView.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  List blogs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  // Fetch blogs from the API
  Future<void> fetchBlogs() async {
    const blogHomepage =
        UrlApi.urlGetAllPosts;
    final response = await http.get(Uri.parse(blogHomepage));

    if (response.statusCode == 200) {
      setState(() {
        blogs = json.decode(response.body)['content'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (category) {
              fetchBlogs();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(
                  value: 'Mental Wellbeing', child: Text('Mental Wellbeing')),
              const PopupMenuItem(value: 'Sleep', child: Text('Sleep')),
              // Add more categories as needed
            ],
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to profile page
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogCard(blog: blog);
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
        // Navigate to the full blog view with the blog data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Blogfullview(blog: blog),
          ),
        );
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
                        blog['title'],
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
                        blog['description'],
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
                  blog['imageUrl'] ?? 'https://th.bing.com/th/id/R.a0d279a6795b1d6bba51798e1841c682?rik=GhZC4ve7o3erFg&riu=http%3a%2f%2fkickstarterz.co.uk%2fwp-content%2fuploads%2f2021%2f02%2fchildren-and-mental-health.png&ehk=oeRfF31I90Ex1KY6wgUsocBuM6k77anjrvk0pVCJWiE%3d&risl=&pid=ImgRaw&r=0',
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


