class Video {
  final String id;
  final String url;
  final String thumbnailUrl;
  final String username;
  int likes;

  Video({
    required this.id,
    required this.url,
    required this.thumbnailUrl,
    required this.username,
    required this.likes,
  });

  Video copyWith({
    String? id,
    String? url,
    String? thumbnailUrl,
    String? username,
    int? likes,
  }) {
    return Video(
      id: id ?? this.id,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      username: username ?? this.username,
      likes: likes ?? this.likes,
    );
  }
}
