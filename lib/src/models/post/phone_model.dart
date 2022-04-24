import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostPhoneModel {
  String id;
  String typePost;
  AddressModel address;
  String brand;
  String color;
  String ram;
  String statusPhone;
  int price;
  PostPhoneModel({
    required this.id,
    required this.typePost,
    required this.address,
    required this.brand,
    required this.color,
    required this.ram,
    required this.statusPhone,
    required this.price,
  });

  PostPhoneModel copyWith({
    String? id,
    String? typePost,
    AddressModel? address,
    String? brand,
    String? color,
    String? ram,
    String? statusPhone,
    int? price,
  }) {
    return PostPhoneModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      ram: ram ?? this.ram,
      statusPhone: statusPhone ?? this.statusPhone,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typePost': typePost,
      'address': address.toMap(),
      'brand': brand,
      'color': color,
      'ram': ram,
      'statusPhone': statusPhone,
      'price': price,
    };
  }

  factory PostPhoneModel.fromMap(Map<String, dynamic> map) {
    return PostPhoneModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      address: AddressModel.fromMap(map['address']),
      brand: map['brand'] ?? '',
      color: map['color'] ?? '',
      ram: map['ram'] ?? '',
      statusPhone: map['statusPhone'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostPhoneModel.fromJson(String source) =>
      PostPhoneModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostPhoneModel(id: $id, typePost: $typePost, address: $address, brand: $brand, color: $color, ram: $ram, statusPhone: $statusPhone, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostPhoneModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.address == address &&
        other.brand == brand &&
        other.color == color &&
        other.ram == ram &&
        other.statusPhone == statusPhone &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        address.hashCode ^
        brand.hashCode ^
        color.hashCode ^
        ram.hashCode ^
        statusPhone.hashCode ^
        price.hashCode;
  }
}
