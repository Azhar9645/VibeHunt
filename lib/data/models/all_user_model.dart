class AllUser {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String? profilePic; // Nullable
  final String? phone;      // Nullable
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final String? backGroundImage; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String? bio;        // Nullable
  final String? name;       // Nullable

  AllUser({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    this.profilePic,         // Nullable
    this.phone,              // Nullable
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    this.backGroundImage,    // Nullable
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.bio,                // Nullable
    this.name,               // Nullable
  });

  factory AllUser.fromJson(Map<String, dynamic> json) {
    return AllUser(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profilePic'],       // Can be null
      phone: json['phone'],                 // Can be null
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      backGroundImage: json['backGroundImage'], // Can be null
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
      bio: json['bio'],                    // Can be null
      name: json['name'],                  // Can be null
    );
  }
}
