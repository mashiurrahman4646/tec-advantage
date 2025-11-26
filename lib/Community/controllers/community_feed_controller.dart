import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../api_service/community_api_service.dart';
import '../models/post_model.dart';

class CommunityFeedController extends GetxController {
  var isLoading = false.obs;
  var isCreatingPost = false.obs;
  var posts = <PostModel>[].obs;
  final selectedImage = Rxn<File>();
  late String groupId;
  late String groupName;

  final ImagePicker _picker = ImagePicker();

  void initialize(String id, String name) {
    groupId = id;
    groupName = name;
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading(true);

    final result = await CommunityApiService.getGroupPosts(groupId);

    isLoading(false);

    if (result != null) {
      posts.value = result;
    } else {
      Get.snackbar(
        'Error',
        'Failed to load posts',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> refreshPosts() async {
    await fetchPosts();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final ext = image.path.toLowerCase().split('.').last;
        final allowed = ['jpg', 'jpeg', 'png'];
        if (!allowed.contains(ext)) {
          Get.snackbar(
            'Unsupported file',
            'Only .jpeg, .png, .jpg are supported',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
          );
          return;
        }
        selectedImage.value = File(image.path);
        Get.snackbar('Success', 'Image selected', snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image. Please check app permissions in Settings.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  void clearImage() {
    selectedImage.value = null;
  }

  Future<bool> createPost(String description,) async {
    if (description.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please write something to post',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    isCreatingPost(true);

    final result = await CommunityApiService.createPost(
      group: groupId,
      description: description.trim().isEmpty ? '' : description,
      image: selectedImage.value,
    );

    isCreatingPost(false);

    if (result != null && result['success'] == true) {
      Get.snackbar(
        'Success',
        'Post created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      clearImage();
      await fetchPosts(); // Refresh posts
      return true;
    } else {
      Get.snackbar(
        'Error',
        result?['message'] ?? 'Failed to create post',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
