import 'dart:convert';

class UserComment {
  String name;
  String email;
  String phone;
  UserComment({
    required this.name,
    required this.email,
    required this.phone,
  });

  UserComment copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return UserComment(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory UserComment.fromMap(Map<String, dynamic> map) {
    return UserComment(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserComment.fromJson(String source) =>
      UserComment.fromMap(json.decode(source));

  @override
  String toString() => 'UserComment(name: $name, email: $email, phone: $phone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserComment &&
        other.name == name &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ phone.hashCode;
}
