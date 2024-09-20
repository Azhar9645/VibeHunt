import 'package:json_annotation/json_annotation.dart';
import 'package:vibehunt/data/models/all_user/creators.dart';

part 'all_user.g.dart';

@JsonSerializable()
class AllUserModel{
  List<Creators>? data;
  int? total;
  AllUserModel({this.data,this.total});
  
  factory AllUserModel.fromJson(Map<String,dynamic>json){
    return _$AllUserModelFromJson(json);
  }
  Map<String,dynamic>toJson()=>_$AllUserModelToJson(this);
}