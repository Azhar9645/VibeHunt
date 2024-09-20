import 'package:json_annotation/json_annotation.dart';
import 'user_id.dart';

part 'my_post_model.g.dart';

@JsonSerializable()
class MyPostModel {
  @JsonKey(name: '_id')
  String? id;
  UserId? userId;
  String? image;
  String? description;
  List<dynamic>? likes;
  bool? hidden;
  bool? blocked;
  List<dynamic>? tags;
  List<dynamic>? taggedUsers;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  DateTime? editedTime;

  MyPostModel({
    this.id,
    this.userId,
    this.image,
    this.description,
    this.likes,
    this.hidden,
    this.blocked,
    this.tags,
    this.taggedUsers,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.editedTime,
  });

  // Factory method for creating an instance from JSON
  factory MyPostModel.fromJson(Map<String, dynamic> json) =>
      _$MyPostModelFromJson(json);

  // Method for serializing to JSON
  Map<String, dynamic> toJson() => _$MyPostModelToJson(this);
}
