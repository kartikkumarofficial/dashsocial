class PostModel {
  final String caption;
  final int likes;
  final int comments;
  final String imageUrl;
  final DateTime createdTime;

  PostModel({
    required this.caption,
    required this.likes,
    required this.comments,
    required this.imageUrl,
    required this.createdTime,
  });
}
