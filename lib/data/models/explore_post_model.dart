import 'dart:convert';

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

  // Static method to create an empty UserModel
  static UserModel empty() {
    return UserModel(
      id: '',
      userName: 'Unknown',
      email: '',
      password: '',
      profilePic: '',
      phone: null,
      online: false,
      blocked: false,
      verified: false,
      role: 'User',
      isPrivate: false,
      backGroundImage: '',
      bio: null,
      name: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  // Factory method to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] ?? '',
        userName:
            json['userName'] ?? 'Unknown', // Fallback to 'Unknown' if null
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        profilePic: json['profilePic'] ?? '',
        phone: json['phone'], // Optional phone
        online: json['online'] ?? false,
        blocked: json['blocked'] ?? false,
        verified: json['verified'] ?? false,
        role: json['role'] ?? 'User',
        isPrivate: json['isPrivate'] ?? false,
        backGroundImage: json['backGroundImage'] ?? '',
        bio: json['bio'], // Optional bio
        name: json['name'], // Optional name
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(), // Use current time if missing
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
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

class ExplorePostModel {
  String id;
  UserModel userId;
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

  // Factory method to create ExplorePostModel from JSON with null checks
  factory ExplorePostModel.fromJson(Map<String, dynamic> json) =>
      ExplorePostModel(
        id: json['_id'] ?? '',
        userId: json['userId'] != null
            ? UserModel.fromJson(json['userId'])
            : UserModel.empty(), // Handle null userId safely
        image: json['image'] ?? '',
        description: json['description'] ?? '', // Fallback to empty description
        likes: json['likes'] != null
            ? List<String>.from(json['likes'])
            : [], // Fallback to empty list if null
        hidden: json['hidden'] ?? false,
        blocked: json['blocked'] ?? false,
        tags: json['tags'] != null
            ? List<String>.from(json['tags'])
            : [], // Fallback to empty list
        taggedUsers: json['taggedUsers'] != null
            ? List<String>.from(json['taggedUsers'])
            : [], // Fallback to empty list
        date: json['date'] != null
            ? DateTime.parse(json['date'])
            : DateTime.now(), // Fallback to current time if missing
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : DateTime.now(),
        v: json['__v'] ?? 0, // Default to 0 if missing
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
