import 'dart:convert';

// Define the UserModel class
class UserModel {
  String id;
  String userName;
  String email;
  String password;
  String profilePic;
  String? phone;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  String backGroundImage;
  String? bio;
  String? name;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePic,
    this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    this.bio,
    this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        userName: json['userName'],
        email: json['email'],
        password: json['password'],
        profilePic: json['profilePic'],
        phone: json['phone'] ?? '',
        online: json['online'],
        blocked: json['blocked'],
        verified: json['verified'],
        role: json['role'],
        isPrivate: json['isPrivate'],
        backGroundImage: json['backGroundImage'],
        bio: json['bio'],
        name: json['name'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() => {
        '_id': id,
        'userName': userName,
        'email': email,
        'password': password,
        'profilePic': profilePic,
        'phone': phone,
        'online': online,
        'blocked': blocked,
        'verified': verified,
        'role': role,
        'isPrivate': isPrivate,
        'backGroundImage': backGroundImage,
        'bio': bio,
        'name': name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}

// Define the ExplorePostModel class
class ExplorePostModel {
  String id;
  UserModel userId; // User who created the post
  String image;
  String description;
  List<String> likes;
  bool hidden;
  bool blocked;
  List<String> tags;
  List<String> taggedUsers;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ExplorePostModel({
    required this.id,
    required this.userId,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // Factory method to create ExplorePostModel from JSON
  factory ExplorePostModel.fromJson(Map<String, dynamic> json) =>
      ExplorePostModel(
        id: json['_id'],
        userId: UserModel.fromJson(json['userId']),
        image: json['image'],
        description: json['description'] ?? '',
        likes: List<String>.from(json['likes']),
        hidden: json['hidden'],
        blocked: json['blocked'],
        tags: List<String>.from(json['tags']),
        taggedUsers: List<String>.from(json['taggedUsers']),
        date: DateTime.parse(json['date']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        v: json['__v'],
      );

  // Method to convert ExplorePostModel to JSON
  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId.toJson(),
        'image': image,
        'description': description,
        'likes': likes,
        'hidden': hidden,
        'blocked': blocked,
        'tags': tags,
        'taggedUsers': taggedUsers,
        'date': date.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };
}

// Function to parse JSON list into a list of ExplorePostModel
List<ExplorePostModel> parsePosts(String jsonResponse) {
  final parsed = jsonDecode(jsonResponse).cast<Map<String, dynamic>>();
  return parsed
      .map<ExplorePostModel>((json) => ExplorePostModel.fromJson(json))
      .toList();
}

// Function to convert list of ExplorePostModel to JSON string
String postsToJson(List<ExplorePostModel> posts) {
  final postsJson = posts.map((post) => post.toJson()).toList();
  return jsonEncode(postsJson);
}
