// community_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';
import 'CommunityFeedPage.dart';
// Import the feed page

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Community',
          style: AppTextStyles.heading2.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: 6, // Show 6 community cards
          itemBuilder: (context, index) {
            return _buildCommunityCard(index);
          },
        ),
      ),
    );
  }

  Widget _buildCommunityCard(int index) {
    // Define the two images that alternate
    List<String> images = [
      'assets/images/tech_room.png', // Tech room image
      'assets/images/startup_room.png', // Startup room image
    ];

    List<String> communityNames = [
      'Tech Community',
      'Startup Community',
    ];

    String imagePath = images[index % 2];
    String communityName = communityNames[index % 2];

    return GestureDetector(
      onTap: () {
        // Navigate to community feed page when tapped
        Get.to(() => CommunityFeedPage(communityName: communityName));
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if image doesn't exist
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: index % 2 == 0
                                ? [Color(0xFF5BA3D4), Color(0xFF4A90C2)]
                                : [Color(0xFFE17C5A), Color(0xFFD86545)],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            index % 2 == 0 ? Icons.computer : Icons.business,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Bottom Section with Company Info
            Container(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  // Company Icon
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.business,
                      size: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(width: 8),
                  // Company Name
                  Expanded(
                    child: Text(
                      'Aspiring Business Solution',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
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
}