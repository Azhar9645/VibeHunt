// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyPostModel _$MyPostModelFromJson(Map<String, dynamic> json) => MyPostModel(
      id: json['_id'] as String?,
      userId: json['userId'] == null
          ? null
          : UserId.fromJson(json['userId'] as Map<String, dynamic>),
      image: json['image'] as String?,
      description: json['description'] as String?,
      likes: json['likes'] as List<dynamic>?,
      hidden: json['hidden'] as bool?,
      blocked: json['blocked'] as bool?,
      tags: json['tags'] as List<dynamic>?,
      taggedUsers: json['taggedUsers'] as List<dynamic>?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      editedTime: json['editedTime'] == null
          ? null
          : DateTime.parse(json['editedTime'] as String),
    );

Map<String, dynamic> _$MyPostModelToJson(MyPostModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'image': instance.image,
      'description': instance.description,
      'likes': instance.likes,
      'hidden': instance.hidden,
      'blocked': instance.blocked,
      'tags': instance.tags,
      'taggedUsers': instance.taggedUsers,
      'date': instance.date?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'editedTime': instance.editedTime?.toIso8601String(),
    };
