import 'package:get/get.dart';
import '../../config_service.dart';
import '../../services/network_caller.dart';
import '../models/user_profile_model.dart';

class UserProfileController extends GetxController {
  bool _isLoading = false;
  String _errorMessage = '';
  UserProfileModel? _userProfileModel;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  UserProfileModel? get userProfileModel => _userProfileModel;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  Future<bool> getUserProfile() async {
    _isLoading = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().get(ApiConfig.userProfile);
    _isLoading = false;
    if (response.isSuccess) {
      _userProfileModel = UserProfileModel.fromJson(response.responseData!);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }

  Future<bool> updateProfile({String? name, String? imagePath}) async {
    _isLoading = true;
    update();

    final Map<String, String> fields = {};
    if (name != null) fields['name'] = name;

    final Map<String, String> files = {};
    if (imagePath != null) files['image'] = imagePath;

    final NetworkResponse response = await NetworkCaller().patchMultipart(
      ApiConfig.userProfile,
      fields: fields,
      files: files,
    );

    _isLoading = false;
    if (response.isSuccess) {
      await getUserProfile(); // Refresh data
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    update();

    final Map<String, dynamic> body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };

    final NetworkResponse response = await NetworkCaller().post(
      ApiConfig.changePassword,
      body: body,
    );

    _isLoading = false;
    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
