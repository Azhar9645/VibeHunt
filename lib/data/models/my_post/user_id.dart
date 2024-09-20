import 'package:json_annotation/json_annotation.dart';

part 'user_id.g.dart';

@JsonSerializable()
class UserId {
  @JsonKey(name: '_id')
  String? id;
  String? userName;
  String? email;
  String? password;
  String? profilePic;
  String? phone;
  bool? online;
  bool? blocked;
  bool? verified;
  String? role;
  bool? isPrivate;
  String? backGroundImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  UserId({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.profilePic,
    this.phone,
    this.online,
    this.blocked,
    this.verified,
    this.role,
    this.isPrivate,
    this.backGroundImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return _$UserIdFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserIdToJson(this);
}
