import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostAparmentModel {
  String id;
  String typePost;
  String type;
  String nameOfBuilding;
  AddressModel address;
  String codeBuilding;
  String block;
  int floor;
  String typeBuilding;
  String numberOfBedroom;
  String numberOfBathroom;
  String balconyDirection;
  String doorDirection;
  String juridical;
  String interiorCondition;
  double area;
  int price;
  PostAparmentModel({
    required this.id,
    required this.typePost,
    required this.type,
    required this.nameOfBuilding,
    required this.address,
    required this.codeBuilding,
    required this.block,
    required this.floor,
    required this.typeBuilding,
    required this.numberOfBedroom,
    required this.numberOfBathroom,
    required this.balconyDirection,
    required this.doorDirection,
    required this.juridical,
    required this.interiorCondition,
    required this.area,
    required this.price,
  });

  PostAparmentModel copyWith({
    String? id,
    String? typePost,
    String? type,
    String? nameOfBuilding,
    AddressModel? address,
    String? codeBuilding,
    String? block,
    int? floor,
    String? typeBuilding,
    String? numberOfBedroom,
    String? numberOfBathroom,
    String? balconyDirection,
    String? doorDirection,
    String? juridical,
    String? interiorCondition,
    double? area,
    int? price,
  }) {
    return PostAparmentModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      type: type ?? this.type,
      nameOfBuilding: nameOfBuilding ?? this.nameOfBuilding,
      address: address ?? this.address,
      codeBuilding: codeBuilding ?? this.codeBuilding,
      block: block ?? this.block,
      floor: floor ?? this.floor,
      typeBuilding: typeBuilding ?? this.typeBuilding,
      numberOfBedroom: numberOfBedroom ?? this.numberOfBedroom,
      numberOfBathroom: numberOfBathroom ?? this.numberOfBathroom,
      balconyDirection: balconyDirection ?? this.balconyDirection,
      doorDirection: doorDirection ?? this.doorDirection,
      juridical: juridical ?? this.juridical,
      interiorCondition: interiorCondition ?? this.interiorCondition,
      area: area ?? this.area,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typePost': typePost,
      'type': type,
      'nameOfBuilding': nameOfBuilding,
      'address': address.toMap(),
      'codeBuilding': codeBuilding,
      'block': block,
      'floor': floor,
      'typeBuilding': typeBuilding,
      'numberOfBedroom': numberOfBedroom,
      'numberOfBathroom': numberOfBathroom,
      'balconyDirection': balconyDirection,
      'doorDirection': doorDirection,
      'juridical': juridical,
      'InteriorCondition': interiorCondition,
      'area': area,
      'price': price,
    };
  }

  factory PostAparmentModel.fromMap(Map<String, dynamic> map) {
    return PostAparmentModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      type: map['type'] ?? '',
      nameOfBuilding: map['nameOfBuilding'] ?? '',
      address: AddressModel.fromMap(map['address']),
      codeBuilding: map['codeBuilding'] ?? '',
      block: map['block'] ?? '',
      floor: map['floor']?.toInt() ?? 0,
      typeBuilding: map['typeBuilding'] ?? '',
      numberOfBedroom: map['numberOfBedroom'] ?? '',
      numberOfBathroom: map['numberOfBathroom'] ?? '',
      balconyDirection: map['balconyDirection'] ?? '',
      doorDirection: map['doorDirection'] ?? '',
      juridical: map['juridical'] ?? '',
      interiorCondition: map['InteriorCondition'] ?? '',
      area: map['area']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostAparmentModel.fromJson(String source) =>
      PostAparmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostAparmentModel(id: $id, typePost: $typePost, type: $type, nameOfBuilding: $nameOfBuilding, address: $address, codeBuilding: $codeBuilding, block: $block, floor: $floor, typeBuilding: $typeBuilding, numberOfBedroom: $numberOfBedroom, numberOfBathroom: $numberOfBathroom, balconyDirection: $balconyDirection, doorDirection: $doorDirection, juridical: $juridical, InteriorCondition: $interiorCondition, area: $area, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostAparmentModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.type == type &&
        other.nameOfBuilding == nameOfBuilding &&
        other.address == address &&
        other.codeBuilding == codeBuilding &&
        other.block == block &&
        other.floor == floor &&
        other.typeBuilding == typeBuilding &&
        other.numberOfBedroom == numberOfBedroom &&
        other.numberOfBathroom == numberOfBathroom &&
        other.balconyDirection == balconyDirection &&
        other.doorDirection == doorDirection &&
        other.juridical == juridical &&
        other.interiorCondition == interiorCondition &&
        other.area == area &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        type.hashCode ^
        nameOfBuilding.hashCode ^
        address.hashCode ^
        codeBuilding.hashCode ^
        block.hashCode ^
        floor.hashCode ^
        typeBuilding.hashCode ^
        numberOfBedroom.hashCode ^
        numberOfBathroom.hashCode ^
        balconyDirection.hashCode ^
        doorDirection.hashCode ^
        juridical.hashCode ^
        interiorCondition.hashCode ^
        area.hashCode ^
        price.hashCode;
  }
}
