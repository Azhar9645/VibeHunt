class FollowingsModel {
  final List<Follower> following;
  final int totalCount;

  FollowingsModel({required this.following, required this.totalCount});

  // Factory constructor to create an instance from JSON
  factory FollowingsModel.fromJson(Map<String, dynamic> json) {
    // Convert the 'following' list from JSON to a list of Follower objects
    var followingJsonList = json['following'] as List;
    List<Follower> followingList = followingJsonList.map((item) => Follower.fromJson(item)).toList();

    return FollowingsModel(
      following: followingList,
      totalCount: json['totalCount'],
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'following': following.map((item) => item.toJson()).toList(),
      'totalCount': totalCount,
    };
  }
}

class Follower {
  final String id;
  final String userName;
  final String email;
  final String profilePic;
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final String backGroundImage;
  final String createdAt;
  final String updatedAt;
  final String? phone;
  final String? password;
  final int v;
  final String? bio;
  final String? name;

  Follower({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePic,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.phone,
    this.password,
    this.bio,
    this.name,
  });

  // Factory constructor to create an instance from JSON
  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      profilePic: json['profilePic'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      backGroundImage: json['backGroundImage'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      phone: json['phone']??'',
      password: json['password'],
      bio: json['bio'],
      name: json['name'],
    );
  }

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'email': email,
      'profilePic': profilePic,
      'online': online,
      'blocked': blocked,
      'verified': verified,
      'role': role,
      'isPrivate': isPrivate,
      'backGroundImage': backGroundImage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'phone': phone,
      'password': password,
      'bio': bio,
      'name': name,
    };
  }
}
