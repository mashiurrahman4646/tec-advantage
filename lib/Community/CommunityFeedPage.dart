// community_feed_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PostDetailsPage.dart';


class CommunityFeedPage extends StatefulWidget {
  final String communityName;

  const CommunityFeedPage({Key? key, required this.communityName}) : super(key: key);

  @override
  State<CommunityFeedPage> createState() => _CommunityFeedPageState();
}

class _CommunityFeedPageState extends State<CommunityFeedPage> {
  final TextEditingController _postController = TextEditingController();

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
          // Post Creation Section
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _postController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write your post or question here',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.image_outlined,
                          color: Colors.grey[600],
                          size: 24,
                        ),
                        onPressed: () {
                          // Handle image selection
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle post submission
                      if (_postController.text.isNotEmpty) {
                        // Add post logic here
                        _postController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post created successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Post',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Feed Section
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: _getFeedPosts().length,
              itemBuilder: (context, index) {
                return _buildFeedPost(_getFeedPosts()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedPost(Map<String, dynamic> post) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
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
                        post['userName'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        post['timeAgo'],
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
              post['content'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),

            // Post images if any
            if (post['images'] != null && post['images'].isNotEmpty) ...[
              SizedBox(height: 12),
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post['images'].length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          post['images'][index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.grey[400],
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            SizedBox(height: 16),

            // Replies section
            GestureDetector(
              onTap: () {
                // Navigate to post details page
                Get.to(() => PostDetailsPage(post: post));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 16,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${post['replies']} Replies',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFeedPosts() {
    return [
      {
        'userName': 'Mohammad Rafiul islam',
        'timeAgo': '12:03 PM',
        'content': 'Hi everyone I\'m planning to launch a small e-commerce business selling handmade crafts. What are some low-cost marketing strategies you\'ve tried that actually worked?',
        'replies': 23,
        'images': null,
      },
      {
        'userName': 'Faisal rabbi',
        'timeAgo': '1h ago',
        'content': 'Finished, \'A little princess\' over the weekend such a powerful memoir!',
        'replies': 23,
        'images': [
          'assets/images/book1.jpg',
          'assets/images/book2.jpg',
        ],
      },
      {
        'userName': 'Sarah Ahmed',
        'timeAgo': '3h ago',
        'content': 'Just completed my first Flutter app! It\'s amazing how much you can accomplish with this framework. Any tips for optimizing performance?',
        'replies': 15,
        'images': null,
      },
      {
        'userName': 'John Smith',
        'timeAgo': '5h ago',
        'content': 'Looking for recommendations on project management tools for small teams. What\'s working well for you?',
        'replies': 8,
        'images': null,
      },
    ];
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}