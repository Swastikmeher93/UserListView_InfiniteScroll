class Post {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final Reactions reactions;
  final int views;
  final int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      tags: List<String>.from(json['tags'] as List),
      reactions: Reactions.fromJson(json['reactions'] as Map<String, dynamic>),
      views: json['views'] as int,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': reactions.toJson(),
      'views': views,
      'userId': userId,
    };
  }
}

class Reactions {
  final int likes;
  final int dislikes;

  Reactions({
    required this.likes,
    required this.dislikes,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) {
    return Reactions(
      likes: json['likes'] as int,
      dislikes: json['dislikes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'dislikes': dislikes,
    };
  }
}
