class GroupModel {
  final String id;
  final String name;
  final String image;
  final CreatedBy createdBy;
  final List<dynamic> members;
  final String createdAt;
  final String updatedAt;

  GroupModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdBy,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      createdBy: CreatedBy.fromJson(json['createdBy'] ?? {}),
      members: json['members'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  String get fullImageUrl {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }
    return 'http://10.10.7.102:3000$image';
  }
}

class CreatedBy {
  final String id;
  final String name;

  CreatedBy({
    required this.id,
    required this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
