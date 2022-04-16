import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostGroundModel {
  String id;
  String typePost;
  String type;
  AddressModel address;
  String typeGround;
  String groundDirection;
  String juridical;
  double area;
  double height;
  double width;
  int price;
  PostGroundModel({
    required this.id,
    required this.typePost,
    required this.type,
    required this.address,
    required this.typeGround,
    required this.groundDirection,
    required this.juridical,
    required this.area,
    required this.height,
    required this.width,
    required this.price,
  });

  PostGroundModel copyWith({
    String? id,
    String? typePost,
    String? type,
    AddressModel? address,
    String? typeGround,
    String? groundDirection,
    String? juridical,
    double? area,
    double? height,
    double? width,
    int? price,
  }) {
    return PostGroundModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      type: type ?? this.type,
      address: address ?? this.address,
      typeGround: typeGround ?? this.typeGround,
      groundDirection: groundDirection ?? this.groundDirection,
      juridical: juridical ?? this.juridical,
      area: area ?? this.area,
      height: height ?? this.height,
      width: width ?? this.width,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typePost': typePost,
      'type': type,
      'address': address.toMap(),
      'typeGround': typeGround,
      'groundDirection': groundDirection,
      'juridical': juridical,
      'area': area,
      'height': height,
      'width': width,
      'price': price,
    };
  }

  factory PostGroundModel.fromMap(Map<String, dynamic> map) {
    return PostGroundModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      type: map['type'] ?? '',
      address: AddressModel.fromMap(map['address']),
      typeGround: map['typeGround'] ?? '',
      groundDirection: map['groundDirection'] ?? '',
      juridical: map['juridical'] ?? '',
      area: map['area']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      width: map['width']?.toDouble() ?? 0.0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostGroundModel.fromJson(String source) =>
      PostGroundModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostGroundModel(id: $id, typePost: $typePost, type: $type, address: $address, typeGround: $typeGround, groundDirection: $groundDirection, juridical: $juridical, area: $area, height: $height, width: $width, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostGroundModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.type == type &&
        other.address == address &&
        other.typeGround == typeGround &&
        other.groundDirection == groundDirection &&
        other.juridical == juridical &&
        other.area == area &&
        other.height == height &&
        other.width == width &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        type.hashCode ^
        address.hashCode ^
        typeGround.hashCode ^
        groundDirection.hashCode ^
        juridical.hashCode ^
        area.hashCode ^
        height.hashCode ^
        width.hashCode ^
        price.hashCode;
  }
}
