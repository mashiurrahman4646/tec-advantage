import 'package:get/get.dart';
import '../services/network_caller.dart';
import '../config_service.dart';
import 'notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await NetworkCaller().get(ApiConfig.notifications);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData!['data'] as List?;
        if (data != null) {
          notifications.value =
              data.map((json) => NotificationModel.fromJson(json)).toList();
        }
      } else {
        errorMessage.value = response.errorMessage;
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch notifications';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final response = await NetworkCaller().patch(
        ApiConfig.markNotificationRead(notificationId),
      );

      if (response.isSuccess) {
        // Update local notification status
        final index = notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          notifications[index] = notifications[index].copyWith(read: true);
          notifications.refresh();
        }
      }
    } catch (e) {
      // Silent fail or show error
      print('Failed to mark notification as read: $e');
    }
  }

  int get unreadCount => notifications.where((n) => !n.read).length;
}
