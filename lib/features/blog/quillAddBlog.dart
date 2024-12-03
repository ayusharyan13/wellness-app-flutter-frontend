import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';

class BlogEditor extends StatefulWidget {
  const BlogEditor({Key? key}) : super(key: key);

  @override
  _BlogEditorState createState() => _BlogEditorState();
}

class _BlogEditorState extends State<BlogEditor> {
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        quill.QuillToolbar.simple(controller: _controller),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Expanded(
            child: quill.QuillEditor.basic(
              controller: _controller,

              configurations: quill.QuillEditorConfigurations(
                autoFocus: true,
              ),
              // readOnly: false, // true for viewing only
            ),
          ),
        ),
      ],
    );
  }
}
