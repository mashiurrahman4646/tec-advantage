class CommentModel {
  final String id;
  final String group;
  final String post;
  final CommentUser user;
  final String text;
  final List<String> images;
  final List<ReplyModel> replies;
  final String createdAt;
  final String updatedAt;

  CommentModel({
    required this.id,
    required this.group,
    required this.post,
    required this.user,
    required this.text,
    required this.images,
    required this.replies,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    // Parse the image field as a list
    List<String> imageList = [];
    if (json['image'] != null) {
      if (json['image'] is List) {
        imageList = (json['image'] as List).map((e) => e.toString()).toList();
      } else if (json['image'] is String &&
          json['image'].toString().isNotEmpty) {
        imageList = [json['image'].toString()];
      }
    }

    // Parse replies
    List<ReplyModel> repliesList = [];
    if (json['replies'] != null && json['replies'] is List) {
      repliesList = (json['replies'] as List)
          .map((reply) => ReplyModel.fromJson(reply))
          .toList();
    }

    return CommentModel(
      id: json['_id'] ?? '',
      group: json['group'] ?? '',
      post: json['post'] ?? '',
      user: CommentUser.fromJson(json['user'] ?? {}),
      text: json['text'] ?? '',
      images: imageList,
      replies: repliesList,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  String? get firstImageUrl {
    if (images.isEmpty) return null;

    final firstImage = images[0];
    if (firstImage.isEmpty) return null;

    if (firstImage.startsWith('http://') || firstImage.startsWith('https://')) {
      return firstImage;
    }

    return 'http://10.10.7.102:3000$firstImage';
  }
}

class ReplyModel {
  final CommentUser user;
  final String text;
  final List<String> images;
  final String createdAt;
  final String id;

  ReplyModel({
    required this.user,
    required this.text,
    required this.images,
    required this.createdAt,
    required this.id,
  });

  factory ReplyModel.fromJson(Map<String, dynamic> json) {
    // Parse the image field as a list
    List<String> imageList = [];
    if (json['image'] != null) {
      if (json['image'] is List) {
        imageList = (json['image'] as List).map((e) => e.toString()).toList();
      } else if (json['image'] is String &&
          json['image'].toString().isNotEmpty) {
        imageList = [json['image'].toString()];
      }
    }

    return ReplyModel(
      user: CommentUser.fromJson(json['user'] ?? {}),
      text: json['text'] ?? '',
      images: imageList,
      createdAt: json['createdAt'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  String? get firstImageUrl {
    if (images.isEmpty) return null;

    final firstImage = images[0];
    if (firstImage.isEmpty) return null;

    if (firstImage.startsWith('http://') || firstImage.startsWith('https://')) {
      return firstImage;
    }

    return 'https://grass-proxy-possible-depends.trycloudflare.com/$firstImage';
  }
}

class CommentUser {
  final String id;
  final String name;
  final String email;

  CommentUser({
    required this.id,
    required this.name,
    required this.email,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
