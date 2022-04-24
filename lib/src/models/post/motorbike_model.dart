import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostMotorbikeModel {
  String id;
  String typePost;
  String type;
  AddressModel address;
  String brand;
  int yearOfRegistration;
  String typeMotorbike;
  String capacity;
  String statusMotorbike;
  int numberOfKm;
  int price;
  PostMotorbikeModel({
    required this.id,
    required this.typePost,
    required this.type,
    required this.address,
    required this.brand,
    required this.yearOfRegistration,
    required this.typeMotorbike,
    required this.capacity,
    required this.statusMotorbike,
    required this.numberOfKm,
    required this.price,
  });

  PostMotorbikeModel copyWith({
    String? id,
    String? typePost,
    String? type,
    AddressModel? address,
    String? brand,
    int? yearOfRegistration,
    String? typeMotorbike,
    String? capacity,
    String? statusMotorbike,
    int? numberOfKm,
    int? price,
  }) {
    return PostMotorbikeModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      type: type ?? this.type,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      yearOfRegistration: yearOfRegistration ?? this.yearOfRegistration,
      typeMotorbike: typeMotorbike ?? this.typeMotorbike,
      capacity: capacity ?? this.capacity,
      statusMotorbike: statusMotorbike ?? this.statusMotorbike,
      numberOfKm: numberOfKm ?? this.numberOfKm,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typePost': typePost,
      'type': type,
      'address': address.toMap(),
      'brand': brand,
      'yearOfRegistration': yearOfRegistration,
      'typeMotorbike': typeMotorbike,
      'capacity': capacity,
      'statusMotorbike': statusMotorbike,
      'numberOfKm': numberOfKm,
      'price': price,
    };
  }

  factory PostMotorbikeModel.fromMap(Map<String, dynamic> map) {
    return PostMotorbikeModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      type: map['type'] ?? '',
      address: AddressModel.fromMap(map['address']),
      brand: map['brand'] ?? '',
      yearOfRegistration: map['yearOfRegistration']?.toInt() ?? 0,
      typeMotorbike: map['typeMotorbike'] ?? '',
      capacity: map['capacity'] ?? '',
      statusMotorbike: map['statusMotorbike'] ?? '',
      numberOfKm: map['numberOfKm']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostMotorbikeModel.fromJson(String source) =>
      PostMotorbikeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostMotorbikeModel(id: $id, typePost: $typePost, type: $type, address: $address, brand: $brand, yearOfRegistration: $yearOfRegistration, typeMotorbike: $typeMotorbike, capacity: $capacity, statusMotorbike: $statusMotorbike, numberOfKm: $numberOfKm, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostMotorbikeModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.type == type &&
        other.address == address &&
        other.brand == brand &&
        other.yearOfRegistration == yearOfRegistration &&
        other.typeMotorbike == typeMotorbike &&
        other.capacity == capacity &&
        other.statusMotorbike == statusMotorbike &&
        other.numberOfKm == numberOfKm &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        type.hashCode ^
        address.hashCode ^
        brand.hashCode ^
        yearOfRegistration.hashCode ^
        typeMotorbike.hashCode ^
        capacity.hashCode ^
        statusMotorbike.hashCode ^
        numberOfKm.hashCode ^
        price.hashCode;
  }
}
