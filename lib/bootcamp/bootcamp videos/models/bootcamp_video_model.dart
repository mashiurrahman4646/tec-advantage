class BootcampVideo {
  final String id;
  final String title;
  final String url;
  final String mark;
  final String category; // 'youtube' or 'udemy'
  final String? filename;
  final String? filepath;
  final DateTime createdAt;
  final DateTime updatedAt;

  BootcampVideo({
    required this.id,
    required this.title,
    required this.url,
    required this.mark,
    required this.category,
    this.filename,
    this.filepath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BootcampVideo.fromJson(Map<String, dynamic> json) {
    return BootcampVideo(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      mark: json['mark'] ?? '',
      category: json['category'] ?? '',
      filename: json['filename'],
      filepath: json['filepath'],
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // Extract YouTube video ID from URL
  String? get youtubeVideoId {
    if (!url.contains('youtube.com') && !url.contains('youtu.be')) return null;

    final uri = Uri.parse(url);
    if (uri.host.contains('youtube.com')) {
      return uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments[0] : null;
    }
    return null;
  }
}
