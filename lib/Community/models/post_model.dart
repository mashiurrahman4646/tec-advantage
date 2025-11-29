class PostModel {
  final String id;
  final GroupInfo group;
  final UserInfo user;
  final String description;
  final List<String> images;
  final String createdAt;
  final String updatedAt;

  PostModel({
    required this.id,
    required this.group,
    required this.user,
    required this.description,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
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

    return PostModel(
      id: json['_id'] ?? '',
      group: GroupInfo.fromJson(json['group'] ?? {}),
      user: UserInfo.fromJson(json['user'] ?? {}),
      description: json['description'] ?? '',
      images: imageList,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  String? get fullImageUrl {
    // Get the first image from the list
    if (images.isEmpty) {
      return null;
    }

    final firstImage = images[0];
    if (firstImage.isEmpty) {
      return null;
    }

    if (firstImage.startsWith('http://') || firstImage.startsWith('https://')) {
      return firstImage;
    }

    return 'https://grass-proxy-possible-depends.trycloudflare.com/$firstImage';
  }
}

class GroupInfo {
  final String id;
  final String name;
  final String image;

  GroupInfo({
    required this.id,
    required this.name,
    required this.image,
  });

  factory GroupInfo.fromJson(Map<String, dynamic> json) {
    return GroupInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class UserInfo {
  final String id;
  final String name;

  UserInfo({
    required this.id,
    required this.name,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final userId = json['_id'] ?? '';
    final userName = json['name'] ?? '';

    return UserInfo(
      id: userId,
      name: userName,
    );
  }
}
