import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/bootcamp_course_model.dart';
import 'services/bootcamp_api_service.dart';
import '../../../config_service.dart';

class CourseDetailsPage extends StatefulWidget {
  final String courseId;
  final String courseName;

  const CourseDetailsPage({
    Key? key,
    required this.courseId,
    required this.courseName,
  }) : super(key: key);

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  bool isLoading = true;
  BootcampCourse? course;

  @override
  void initState() {
    super.initState();
    _fetchCourseDetails();
  }

  Future<void> _fetchCourseDetails() async {
    setState(() => isLoading = true);
    final result = await BootcampApiService.getCourseById(widget.courseId);
    setState(() {
      course = result;
      isLoading = false;
    });
  }

  Future<void> _openContent(CourseContent content) async {
    final baseUrl = Uri.parse(ApiConfig.baseUrl).origin;
    String url;
    if (content.isVideo) {
      // Construct video URL: http://10.10.7.102:3000/media/filename.mp4
      url = '$baseUrl/media/${content.url}';
    } else {
      // For PDFs: http://10.10.7.102:3000/doc/filename.pdf
      url = '$baseUrl/doc/${content.url}';
    }

    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'Could not open content',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

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
          widget.courseName,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : course == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Failed to load course details',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _fetchCourseDetails,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : course!.modules.isEmpty
                  ? Center(
                      child: Text(
                        'No modules available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(24),
                      itemCount: course!.modules.length,
                      itemBuilder: (context, index) {
                        final module = course!.modules[index];
                        return _buildModuleCard(module, index + 1);
                      },
                    ),
    );
  }

  Widget _buildModuleCard(CourseModule module, int moduleNumber) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Theme(
          data: ThemeData(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            childrenPadding: EdgeInsets.only(bottom: 8),
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '$moduleNumber',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
              ),
            ),
            title: Text(
              module.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            subtitle: module.contents.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${module.totalVideos} videos, ${module.totalPdfs} PDFs',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : null,
            children: module.contents.isEmpty
                ? [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        'No content available',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ]
                : module.contents
                    .map((content) => _buildContentItem(content))
                    .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildContentItem(CourseContent content) {
    return InkWell(
      onTap: () => _openContent(content),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: content.isVideo ? Colors.red[50] : Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                content.isVideo
                    ? Icons.play_circle_outline
                    : Icons.picture_as_pdf,
                color: content.isVideo ? Colors.red[600] : Colors.blue[600],
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    content.isVideo ? 'Video' : 'PDF Document',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: 18, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
