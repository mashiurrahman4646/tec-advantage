import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../api_service/community_api_service.dart';
import '../models/comment_model.dart';

class PostDetailsController extends GetxController {
  late String postId;
  late String groupId;

  final isLoading = false.obs;
  final comments = <CommentModel>[].obs;
  final selectedImage = Rxn<File>();
  final replyingToCommentId = RxnString();
  final replyingToUserName = RxnString();

  final ImagePicker _picker = ImagePicker();

  void initialize(String gid, String pid) {
    groupId = gid;
    postId = pid;
    fetchComments();
  }

  Future<void> fetchComments() async {
    isLoading(true);
    final result = await CommunityApiService.getPostComments(postId);
    isLoading(false);
    if (result != null) {
      comments.value = result;
    }
  }

  Future<void> refreshComments() async {
    await fetchComments();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final ext = image.path.toLowerCase().split('.').last;
        final allowed = ['jpg', 'jpeg', 'png'];
        if (!allowed.contains(ext)) {
          Get.snackbar(
              'Unsupported file', 'Only .jpeg, .png, .jpg are supported',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
        selectedImage.value = File(image.path);
      }
    } catch (_) {}
  }

  void removeImage() {
    selectedImage.value = null;
  }

  void startReply(String commentId, String userName) {
    replyingToCommentId.value = commentId;
    replyingToUserName.value = userName;
  }

  void cancelReply() {
    replyingToCommentId.value = null;
    replyingToUserName.value = null;
  }

  Future<bool> createComment(String text) async {
    if (replyingToCommentId.value != null) {
      return await _sendReply(text);
    }

    final res = await CommunityApiService.createComment(
      groupId: groupId,
      postId: postId,
      text: text,
      image: selectedImage.value,
    );
    if (res != null && (res['success'] == true || res['message'] != null)) {
      removeImage();
      await fetchComments();
      return true;
    }
    return false;
  }

  Future<bool> _sendReply(String text) async {
    final res = await CommunityApiService.replyToComment(
      commentId: replyingToCommentId.value!,
      text: text,
      image: selectedImage.value,
    );
    if (res != null && (res['success'] == true || res['message'] != null)) {
      removeImage();
      cancelReply();
      await fetchComments();
      return true;
    }
    return false;
  }
}
