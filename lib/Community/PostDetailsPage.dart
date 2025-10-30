// post_details_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailsPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    // Load sample comments
    comments = _getSampleComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Community',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Main Post Section
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post['userName'],
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.post['timeAgo'],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Post content
                Text(
                  widget.post['content'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Comments Section
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return _buildComment(comments[index]);
              },
            ),
          ),

          // Comment Input Section
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                children: [
                  // Image attachment button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.image_outlined,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      onPressed: () {
                        // Handle image selection
                      },
                    ),
                  ),
                  SizedBox(width: 12),

                  // Comment input field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Write your Comment',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

                  // Send button
                  GestureDetector(
                    onTap: () {
                      if (_commentController.text.isNotEmpty) {
                        _addComment(_commentController.text);
                        _commentController.clear();
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(Map<String, dynamic> comment) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
              size: 18,
            ),
          ),
          SizedBox(width: 12),

          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User name and time
                Row(
                  children: [
                    Text(
                      comment['userName'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      comment['timeAgo'],
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),

                // Comment text
                Text(
                  comment['content'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8),

                // Reply button
                GestureDetector(
                  onTap: () {
                    // Handle reply
                  },
                  child: Text(
                    'Reply',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),

          // More options
          Icon(
            Icons.more_horiz,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
      ),
    );
  }

  void _addComment(String commentText) {
    setState(() {
      comments.insert(0, {
        'userName': 'You',
        'timeAgo': 'now',
        'content': commentText,
      });
    });
  }

  List<Map<String, dynamic>> _getSampleComments() {
    return [
      {
        'userName': 'Noah Pierre',
        'timeAgo': '28 min ago',
        'content': 'WhatsApp and Facebook groups are underrated. I created a local buyers\' group and kept posting discounts—got my first 50 customers from there.',
      },
      {
        'userName': 'Noah Pierre',
        'timeAgo': '30 min ago',
        'content': 'WhatsApp and Facebook groups are underrated. I created a local buyers\' group and kept posting discounts—got my first 50 customers from there.',
      },
      {
        'userName': 'Noah Pierre',
        'timeAgo': '32 min ago',
        'content': 'WhatsApp and Facebook groups are underrated. I created a local buyers\' group and kept posting discounts—got my first 50 customers from there.',
      },
      {
        'userName': 'Noah Pierre',
        'timeAgo': '35 min ago',
        'content': 'WhatsApp and Facebook groups are underrated. I created a local buyers\' group and kept posting discounts—got my first 50 customers from there.',
      },
      {
        'userName': 'Noah Pierre',
        'timeAgo': '38 min ago',
        'content': 'WhatsApp and Facebook groups are underrated. I created a local buyers\' group and kept posting discounts—got my first 50 customers from there.',
      },
    ];
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}