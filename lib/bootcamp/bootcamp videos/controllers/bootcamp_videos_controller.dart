import 'package:get/get.dart';
import '../models/bootcamp_video_model.dart';
import '../models/bootcamp_course_model.dart';
import '../services/bootcamp_api_service.dart';

class BootcampVideosController extends GetxController {
  final isLoading = false.obs;
  final videos = <BootcampVideo>[].obs;
  final courses = <BootcampCourse>[].obs;

  List<BootcampVideo> get youtubeVideos =>
      videos.where((v) => v.category.toLowerCase() == 'youtube').toList();

  List<BootcampVideo> get udemyVideos =>
      videos.where((v) => v.category.toLowerCase() == 'udemy').toList();

  @override
  void onInit() {
    super.onInit();
    fetchVideos();
    fetchCourses();
  }

  Future<void> fetchVideos() async {
    isLoading(true);
    final result = await BootcampApiService.getVideos();
    if (result != null) {
      videos.value = result;
    }
    isLoading(false);
  }

  Future<void> fetchCourses() async {
    final result = await BootcampApiService.getCourses();
    if (result != null) {
      courses.value = result;
    }
  }
}
