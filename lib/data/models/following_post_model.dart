import 'package:vibehunt/data/models/profile/following_user_model.dart';

class FollowingPostModel {
  List<dynamic> taggedUsers;
  String? id;
  FollowingUserIdModel userId;
  String? image;
  String? description;
  List<FollowingUserIdModel> likes;
  bool? hidden;
  bool? blocked;
  List<String> tags;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  int? v;
  bool? isLiked;
  bool? isSaved;
  DateTime? editedTime;
  int? commentCount;

  FollowingPostModel(
      {required this.taggedUsers,
      required this.id,
      required this.userId,
      required this.image,
      required this.description,
      required this.likes,
      required this.hidden,
      required this.blocked,
      required this.tags,
      required this.date,
      required this.createdAt,
      required this.updatedAt,
      required this.v,
      this.isLiked,
      this.isSaved,
      this.editedTime,
      this.commentCount});

  factory FollowingPostModel.fromJson(Map<String, dynamic> json) =>
      FollowingPostModel(
          taggedUsers: List<dynamic>.from(json["taggedUsers"].map((x) => x)),
          id: json["_id"],
          userId: FollowingUserIdModel.fromJson(json["userId"]),
          image: json["image"],
          description: json["description"],
          likes: List<FollowingUserIdModel>.from(
              json["likes"].map((x) => FollowingUserIdModel.fromJson(x))),
          hidden: json["hidden"],
          blocked: json["blocked"],
          tags: List<String>.from(json["tags"].map((x) => x)),
          date: DateTime.parse(json["date"]),
          createdAt: DateTime.parse(json["createdAt"]),
          updatedAt: DateTime.parse(json["updatedAt"]),
          v: json["__v"],
          isLiked: json["isLiked"],
          isSaved: json["isSaved"],
          commentCount: json["commentCount"],
          editedTime: DateTime.parse(json["edited"]));

  Map<String, dynamic> toJson() => {
        "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x)),
        "_id": id,
        "userId": userId.toJson(),
        "image": image,
        "description": description,
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "hidden": hidden,
        "blocked": blocked,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isLiked": isLiked,
        "isSaved": isSaved,
        "edited": editedTime,
        "commentCount": commentCount,
      };
}
