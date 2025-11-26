import 'package:get/get.dart';
import '../api_service/community_api_service.dart';
import '../models/group_model.dart';

class CommunityController extends GetxController {
  var isLoading = false.obs;
  var groups = <GroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchGroups();
  }

  Future<void> fetchGroups() async {
    isLoading(true);

    final result = await CommunityApiService.getGroups();

    isLoading(false);

    if (result != null) {
      groups.value = result;
    } else {
      Get.snackbar(
        'Error',
        'Failed to load groups',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> refreshGroups() async {
    await fetchGroups();
  }
}
