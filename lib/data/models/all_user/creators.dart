import 'package:json_annotation/json_annotation.dart';

part 'creators.g.dart';

@JsonSerializable()
class Creators{
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
  String? bio;
  String? name;

  Creators({
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
    this.bio,
    this.name,
  });
factory Creators.fromJson(Map<String, dynamic> json) => _$CreatorsFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorsToJson(this);}