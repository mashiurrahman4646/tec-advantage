class CourseContent {
  final String id;
  final String type; // 'video' or 'pdf'
  final String title;
  final String url;

  CourseContent({
    required this.id,
    required this.type,
    required this.title,
    required this.url,
  });

  factory CourseContent.fromJson(Map<String, dynamic> json) {
    return CourseContent(
      id: json['_id'] ?? '',
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }

  bool get isVideo => type.toLowerCase() == 'video';
  bool get isPdf => type.toLowerCase() == 'pdf';
}

class CourseModule {
  final String id;
  final String name;
  final List<CourseContent> contents;

  CourseModule({
    required this.id,
    required this.name,
    required this.contents,
  });

  factory CourseModule.fromJson(Map<String, dynamic> json) {
    List<CourseContent> contentList = [];
    if (json['contents'] != null) {
      contentList = (json['contents'] as List)
          .map((content) => CourseContent.fromJson(content))
          .toList();
    }

    return CourseModule(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      contents: contentList,
    );
  }

  int get totalVideos => contents.where((c) => c.isVideo).length;
  int get totalPdfs => contents.where((c) => c.isPdf).length;
}

class BootcampCourse {
  final String id;
  final String name;
  final List<CourseModule> modules;
  final DateTime createdAt;
  final DateTime updatedAt;

  BootcampCourse({
    required this.id,
    required this.name,
    required this.modules,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BootcampCourse.fromJson(Map<String, dynamic> json) {
    List<CourseModule> moduleList = [];
    if (json['modules'] != null) {
      moduleList = (json['modules'] as List)
          .map((module) => CourseModule.fromJson(module))
          .toList();
    }

    return BootcampCourse(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      modules: moduleList,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  int get totalModules => modules.length;
  int get totalContents =>
      modules.fold(0, (sum, module) => sum + module.contents.length);
}
