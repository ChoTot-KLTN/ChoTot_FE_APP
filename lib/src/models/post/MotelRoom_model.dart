import 'dart:convert';
import 'dart:ffi';

import 'package:chotot_app/src/models/address_model.dart';

class PostMotelRoomModel {
  String id;
  String typePost;
  AddressModel address;
  String type;
  String interiorCondition;
  int area;
  int price;
  int deposit;
  PostMotelRoomModel({
    required this.id,
    required this.typePost,
    required this.address,
    required this.type,
    required this.interiorCondition,
    required this.area,
    required this.price,
    required this.deposit,
  });

  PostMotelRoomModel copyWith({
    String? id,
    String? typePost,
    AddressModel? address,
    String? type,
    String? interiorCondition,
    int? area,
    int? price,
    int? deposit,
  }) {
    return PostMotelRoomModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      address: address ?? this.address,
      type: type ?? this.type,
      interiorCondition: interiorCondition ?? this.interiorCondition,
      area: area ?? this.area,
      price: price ?? this.price,
      deposit: deposit ?? this.deposit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typePost': typePost,
      'address': address.toMap(),
      'type': type,
      'interiorCondition': interiorCondition,
      'area': area,
      'price': price,
      'deposit': deposit,
    };
  }

  factory PostMotelRoomModel.fromMap(Map<String, dynamic> map) {
    return PostMotelRoomModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      address: AddressModel.fromMap(map['address']),
      type: map['type'] ?? '',
      interiorCondition: map['interiorCondition'] ?? '',
      area: map['area'] ?? 0.0,
      price: map['price']?.toInt() ?? 0,
      deposit: map['deposit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostMotelRoomModel.fromJson(String source) =>
      PostMotelRoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostMotelRoomModel(id: $id, typePost: $typePost, address: $address, type: $type, interiorCondition: $interiorCondition, area: $area, price: $price, deposit: $deposit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostMotelRoomModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.address == address &&
        other.type == type &&
        other.interiorCondition == interiorCondition &&
        other.area == area &&
        other.price == price &&
        other.deposit == deposit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        address.hashCode ^
        type.hashCode ^
        interiorCondition.hashCode ^
        area.hashCode ^
        price.hashCode ^
        deposit.hashCode;
  }
}
