// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserId _$UserIdFromJson(Map<String, dynamic> json) => UserId(
      id: json['_id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      profilePic: json['profilePic'] as String?,
      phone: json['phone'] as String?,
      online: json['online'] as bool?,
      blocked: json['blocked'] as bool?,
      verified: json['verified'] as bool?,
      role: json['role'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      backGroundImage: json['backGroundImage'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserIdToJson(UserId instance) => <String, dynamic>{
      '_id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'profilePic': instance.profilePic,
      'phone': instance.phone,
      'online': instance.online,
      'blocked': instance.blocked,
      'verified': instance.verified,
      'role': instance.role,
      'isPrivate': instance.isPrivate,
      'backGroundImage': instance.backGroundImage,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
