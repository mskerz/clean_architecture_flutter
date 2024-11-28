
// โมเดลที่ใช้ร่วมกันในทุกๆ Layer
class Posts {
  final int id;
  final String title;
  final String body;
  final List<String> tags;
  final Reactions reactions;
  final int views;
  final int userId;

  Posts({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    reactions: Reactions.fromJson(json["reactions"]),
    views: json["views"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "reactions": reactions.toJson(),
    "views": views,
    "userId": userId,
  };
}

class Reactions {
  final int likes;
  final int dislikes;

  Reactions({
    required this.likes,
    required this.dislikes,
  });

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
    likes: json["likes"],
    dislikes: json["dislikes"],
  );

  Map<String, dynamic> toJson() => {
    "likes": likes,
    "dislikes": dislikes,
  };
}
