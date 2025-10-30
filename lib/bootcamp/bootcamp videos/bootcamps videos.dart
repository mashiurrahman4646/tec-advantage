import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BootcampVideosScreen extends StatelessWidget {
  const BootcampVideosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Bootcamp',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main heading
            Text(
              'Learn Anytime, Anywhere',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Bootcamp videos from Udemy, YouTube, and Admin - all in one place',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),

            // Udemy Videos Section
            Text(
              'Udemy Videos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildVideoCard(
                    'Mastering Business',
                    Colors.teal[700]!,
                    'udemy',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVideoCard(
                    'Mastering Business',
                    Colors.teal[400]!,
                    null,
                    hasDecorations: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // YouTube Videos Section
            Text(
              'Youtube Videos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildVideoCard(
                    'Mastering Business',
                    Colors.blue[200]!,
                    null,
                    isOcean: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVideoCard(
                    'Mastering Business',
                    Colors.blue[300]!,
                    null,
                    isOcean: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Admin Uploads Video Section
            Text(
              'Admin Uploads Video',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildVideoCard(
                    'Mastering Business',
                    Colors.grey[300]!,
                    'ADMIN',
                    isAdmin: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVideoCard(
                    'Mastering Business',
                    Colors.teal[300]!,
                    null,
                    hasPlayButton: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(
      String title,
      Color backgroundColor,
      String? logoText, {
        bool hasDecorations = false,
        bool isOcean = false,
        bool isAdmin = false,
        bool hasPlayButton = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Ocean wave pattern for YouTube videos
              if (isOcean)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ),

              // Decorative circles
              if (hasDecorations)
                Positioned(
                  top: -10,
                  right: -10,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

              if (hasDecorations)
                Positioned(
                  top: 20,
                  right: 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

              // Logo text (Udemy/Admin)
              if (logoText != null)
                Center(
                  child: isAdmin
                      ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      logoText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  )
                      : Text(
                    logoText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

              // Play button
              if (hasPlayButton)
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.teal,
                      size: 24,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}