import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class HouseModel {
  String id;
  double area;
  double height;
  double width;
  int price;
  String numberOfBedroom;
  String numberOfBathroom;
  String juridical;
  String typeHouse;
  String interiorCondition;
  AddressModel address;
  String type;
  HouseModel({
    required this.id,
    required this.area,
    required this.height,
    required this.width,
    required this.price,
    required this.numberOfBedroom,
    required this.numberOfBathroom,
    required this.juridical,
    required this.typeHouse,
    required this.interiorCondition,
    required this.address,
    required this.type,
  });

  HouseModel copyWith({
    String? id,
    double? area,
    double? height,
    double? width,
    int? price,
    String? numberOfBedroom,
    String? numberOfBathroom,
    String? juridical,
    String? typeHouse,
    String? interiorCondition,
    AddressModel? address,
    String? type,
  }) {
    return HouseModel(
      id: id ?? this.id,
      area: area ?? this.area,
      height: height ?? this.height,
      width: width ?? this.width,
      price: price ?? this.price,
      numberOfBedroom: numberOfBedroom ?? this.numberOfBedroom,
      numberOfBathroom: numberOfBathroom ?? this.numberOfBathroom,
      juridical: juridical ?? this.juridical,
      typeHouse: typeHouse ?? this.typeHouse,
      interiorCondition: interiorCondition ?? this.interiorCondition,
      address: address ?? this.address,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'area': area,
      'height': height,
      'width': width,
      'price': price,
      'numberOfBedroom': numberOfBedroom,
      'numberOfBathroom': numberOfBathroom,
      'juridical': juridical,
      'typeHouse': typeHouse,
      'interiorCondition': interiorCondition,
      'address': address.toMap(),
      'type': type,
    };
  }

  factory HouseModel.fromMap(Map<String, dynamic> map) {
    return HouseModel(
      id: map['_id'] ?? '',
      area: map['area']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      width: map['width']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
      numberOfBedroom: map['numberOfBedroom'] ?? '',
      numberOfBathroom: map['numberOfBathroom'] ?? '',
      juridical: map['juridical'] ?? '',
      typeHouse: map['typeHouse'] ?? '',
      interiorCondition: map['InteriorCondition'] ?? '',
      address: AddressModel.fromMap(map['address']),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseModel.fromJson(String source) =>
      HouseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseModel(id: $id, area: $area, height: $height, width: $width, price: $price, numberOfBedroom: $numberOfBedroom, numberOfBathroom: $numberOfBathroom, juridical: $juridical, typeHouse: $typeHouse, interiorCondition: $interiorCondition, address: $address, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseModel &&
        other.id == id &&
        other.area == area &&
        other.height == height &&
        other.width == width &&
        other.price == price &&
        other.numberOfBedroom == numberOfBedroom &&
        other.numberOfBathroom == numberOfBathroom &&
        other.juridical == juridical &&
        other.typeHouse == typeHouse &&
        other.interiorCondition == interiorCondition &&
        other.address == address &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        area.hashCode ^
        height.hashCode ^
        width.hashCode ^
        price.hashCode ^
        numberOfBedroom.hashCode ^
        numberOfBathroom.hashCode ^
        juridical.hashCode ^
        typeHouse.hashCode ^
        interiorCondition.hashCode ^
        address.hashCode ^
        type.hashCode;
  }
}
