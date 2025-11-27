import '../../../services/network_caller.dart';
import '../models/bootcamp_video_model.dart';
import '../models/bootcamp_course_model.dart';

class BootcampApiService {
  static Future<List<BootcampVideo>?> getVideos() async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get('/bootcamp/videos');

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          return data.map((json) => BootcampVideo.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<BootcampCourse>?> getCourses() async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get('/bootcamp/courses');

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          return data.map((json) => BootcampCourse.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<BootcampCourse?> getCourseById(String courseId) async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get('/bootcamp/courses/$courseId');

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'];
        if (data != null) {
          return BootcampCourse.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
