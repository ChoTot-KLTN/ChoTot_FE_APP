import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostOfficeModel {
  String id;
  String typePost;
  String type;
  AddressModel address;
  String typeOffice;
  String doorDirection;
  String juridical;
  String interiorCondition;
  int price;
  double area;
  PostOfficeModel({
    required this.id,
    required this.typePost,
    required this.type,
    required this.address,
    required this.typeOffice,
    required this.doorDirection,
    required this.juridical,
    required this.interiorCondition,
    required this.price,
    required this.area,
  });

  PostOfficeModel copyWith({
    String? id,
    String? typePost,
    String? type,
    AddressModel? address,
    String? typeOffice,
    String? doorDirection,
    String? juridical,
    String? interiorCondition,
    int? price,
    double? area,
  }) {
    return PostOfficeModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      type: type ?? this.type,
      address: address ?? this.address,
      typeOffice: typeOffice ?? this.typeOffice,
      doorDirection: doorDirection ?? this.doorDirection,
      juridical: juridical ?? this.juridical,
      interiorCondition: interiorCondition ?? this.interiorCondition,
      price: price ?? this.price,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typePost': typePost,
      'type': type,
      'address': address.toMap(),
      'typeOffice': typeOffice,
      'doorDirection': doorDirection,
      'juridical': juridical,
      'interiorCondition': interiorCondition,
      'price': price,
      'area': area,
    };
  }

  factory PostOfficeModel.fromMap(Map<String, dynamic> map) {
    return PostOfficeModel(
      id: map['id'] ?? '',
      typePost: map['typePost'] ?? '',
      type: map['type'] ?? '',
      address: AddressModel.fromMap(map['address']),
      typeOffice: map['typeOffice'] ?? '',
      doorDirection: map['doorDirection'] ?? '',
      juridical: map['juridical'] ?? '',
      interiorCondition: map['interiorCondition'] ?? '',
      price: map['price']?.toInt() ?? 0,
      area: map['area']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostOfficeModel.fromJson(String source) =>
      PostOfficeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostOfficeModel(id: $id, typePost: $typePost, type: $type, address: $address, typeOffice: $typeOffice, doorDirection: $doorDirection, juridical: $juridical, interiorCondition: $interiorCondition, price: $price, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostOfficeModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.type == type &&
        other.address == address &&
        other.typeOffice == typeOffice &&
        other.doorDirection == doorDirection &&
        other.juridical == juridical &&
        other.interiorCondition == interiorCondition &&
        other.price == price &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        type.hashCode ^
        address.hashCode ^
        typeOffice.hashCode ^
        doorDirection.hashCode ^
        juridical.hashCode ^
        interiorCondition.hashCode ^
        price.hashCode ^
        area.hashCode;
  }
}
