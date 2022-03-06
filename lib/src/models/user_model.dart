import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final AddressModel address;
  final int ratings;
  final int posts;
  final String role;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.ratings,
    required this.posts,
    required this.role,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    AddressModel? address,
    int? ratings,
    int? posts,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      ratings: ratings ?? this.ratings,
      posts: posts ?? this.posts,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address.toMap(),
      'ratings': ratings,
      'posts': posts,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: AddressModel.fromMap(map['address']),
      ratings: map['ratings']?.toInt() ?? 0,
      posts: map['posts']?.toInt() ?? 0,
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone, address: $address, ratings: $ratings, posts: $posts, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.ratings == ratings &&
        other.posts == posts &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        ratings.hashCode ^
        posts.hashCode ^
        role.hashCode;
  }
}
