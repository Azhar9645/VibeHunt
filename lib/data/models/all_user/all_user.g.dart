// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllUserModel _$AllUserModelFromJson(Map<String, dynamic> json) => AllUserModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Creators.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllUserModelToJson(AllUserModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };
