class PostModel {
  final String caption;
  final int likes;
  final int comments;
  final String imageUrl;
  final DateTime createdTime;
  final DateTime? scheduledAt;

  PostModel({
    required this.caption,
    required this.likes,
    required this.comments,
    required this.imageUrl,
    required this.createdTime,
    this.scheduledAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      caption: json['caption'] ?? '',
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      createdTime: DateTime.parse(json['created_at']),
      scheduledAt: json['scheduled_at'] != null
          ? DateTime.parse(json['scheduled_at'])
          : null,
    );
  }
}
