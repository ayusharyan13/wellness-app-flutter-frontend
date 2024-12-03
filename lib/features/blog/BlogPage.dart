import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants/urlApi.dart';
import 'BlogFullView.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen>
    with SingleTickerProviderStateMixin {
  List blogs = [];
  bool isLoading = true;

  // Category mapping
  final Map<int, String> categoryNames = {
    1: 'Academic Pressure',
    2: 'Sleep Issues',
    3: 'Wellness Tips',
    4: 'Mental Health Tips',
  };

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categoryNames.length, vsync: this);

    // Fetch blogs initially for the first category
    fetchBlogs(1);

    // Fetch blogs when the tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // Wait until the tab is fully changed
      fetchBlogs(_tabController.index + 1); // Fetch blogs for the new category
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
        title: const Text('Blogs'),
        bottom: TabBar(
          controller: _tabController,
          tabs: categoryNames.values
              .map((category) => Tab(text: category))
              .toList(),
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categoryNames.keys.map((categoryId) {
          return isLoading
              ? const Center(child: CircularProgressIndicator())
              : blogs.isEmpty
              ? const Center(child: Text('No blogs available for this category.'))
              : ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final blog = blogs[index];
              return BlogCard(blog: blog);
            },
          );
        }).toList(),
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
                  blog['imageUrl'] ?? 'https://via.placeholder.com/100',
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
