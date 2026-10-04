class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.status = 'active',
    this.avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? role,
    String? status,
    String? avatarUrl,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
