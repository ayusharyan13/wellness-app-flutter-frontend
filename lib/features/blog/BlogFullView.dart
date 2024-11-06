import 'package:flutter/material.dart';

class Blogfullview extends StatelessWidget {
  final Map<String, dynamic> blog;

  const Blogfullview({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog['title'] ?? 'Blog Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the blog title
            Text(
              blog['title'] ?? 'No Title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Display the blog description
            Text(
              blog['description'] ?? 'No Description',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Display the blog content
            Text(
              blog['content'] ?? 'No Content',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // Display the image if available
            if (blog['imageUrl'] != null)
              Center(
                child: Image.network(
                  blog['imageUrl'],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            else
              const SizedBox.shrink(),

            const SizedBox(height: 20),

            // Display the comments
            if (blog['comments'] != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...blog['comments'].map<Widget>((comment) {
                    return ListTile(
                      title: Text(comment['name']),
                      subtitle: Text(comment['body']),
                    );
                  }).toList(),
                ],
              )
            else
              const Text('No comments available'),
          ],
        ),
      ),
    );
  }
}
