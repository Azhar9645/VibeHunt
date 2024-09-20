class AllUser {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String profilePic;
  final String phone;
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final String backGroundImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String bio;
  final String name;

  AllUser({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.bio,
    required this.name,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) {
    return AllUser(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profilePic'],
      phone: json['phone'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      backGroundImage: json['backGroundImage'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
      bio: json['bio'],
      name: json['name'],
    );
  }
}
