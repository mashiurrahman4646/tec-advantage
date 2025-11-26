import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import '../../config_service.dart';
import '../../services/network_caller.dart';
import '../../token_service/token_service.dart';
import '../models/group_model.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

class CommunityApiService {
  static Future<List<GroupModel>?> getGroups() async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get(ApiConfig.groups);

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          return data.map((json) => GroupModel.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<PostModel>?> getGroupPosts(String groupId) async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get(ApiConfig.groupPosts(groupId));

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          return data.map((json) => PostModel.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<CommentModel>?> getPostComments(String postId) async {
    try {
      final caller = NetworkCaller();
      final res = await caller.get(ApiConfig.getComments(postId));

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'] as List<dynamic>?;
        if (data != null) {
          return data.map((json) => CommentModel.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> createPost({
    required String group,
    required String description,
    required File? image,
  }) async {
    print('createPostxx: $group, $description, $image');
    try {
      final uri =
          Uri.parse('${ApiConfig.baseUrl}${ApiConfig.groupPosts(group)}');
      var request = http.MultipartRequest('POST', uri);
      print('createPostxx: $uri');
      final authHeaders = await TokenService.authHeaders();
      authHeaders.remove('Content-Type');
      request.headers.addAll(authHeaders);

      print('createPostxx: $authHeaders');
      // Only description in body
      request.fields['description'] = description;

      print('createPostxx: ${request.fields}');
      if (image != null) {
        final ext = image.path.toLowerCase().split('.').last;
        final subtype = (ext == 'png') ? 'png' : 'jpeg';
        final ct = MediaType('image', subtype);
        final filename = image.path.split('/').last;
        final stream = http.ByteStream(image.openRead());
        final length = await image.length();
        final multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: filename,
          contentType: ct,
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(responseData);
        return decoded;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> createComment({
    required String groupId,
    required String postId,
    required String text,
    required File? image,
  }) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.createComment(groupId, postId)}');
      var request = http.MultipartRequest('POST', uri);
      final authHeaders = await TokenService.authHeaders();
      authHeaders.remove('Content-Type');
      request.headers.addAll(authHeaders);

      request.fields['text'] = text;
      // No 'post' field required as postId is in path

      if (image != null) {
        final ext = image.path.toLowerCase().split('.').last;
        final subtype = (ext == 'png') ? 'png' : 'jpeg';
        final ct = MediaType('image', subtype);
        final filename = image.path.split('/').last;
        final stream = http.ByteStream(image.openRead());
        final length = await image.length();
        final multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: filename,
          contentType: ct,
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(responseData);
        return decoded is Map<String, dynamic> ? decoded : {'success': true};
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
