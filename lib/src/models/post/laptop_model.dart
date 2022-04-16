import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostLaptopModel {
  String id;
  String typePost;
  AddressModel address;
  String brand;
  String color;
  String microprocessor;
  String ram;
  String hardDrive;
  String typeHardDrive;
  String graphicsCard;
  String statusLaptop;
  String guarantee;
  int price;
  PostLaptopModel({
    required this.id,
    required this.typePost,
    required this.address,
    required this.brand,
    required this.color,
    required this.microprocessor,
    required this.ram,
    required this.hardDrive,
    required this.typeHardDrive,
    required this.graphicsCard,
    required this.statusLaptop,
    required this.guarantee,
    required this.price,
  });

  PostLaptopModel copyWith({
    String? id,
    String? typePost,
    AddressModel? address,
    String? brand,
    String? color,
    String? microprocessor,
    String? ram,
    String? hardDrive,
    String? typeHardDrive,
    String? graphicsCard,
    String? statusLaptop,
    String? guarantee,
    int? price,
  }) {
    return PostLaptopModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      color: color ?? this.color,
      microprocessor: microprocessor ?? this.microprocessor,
      ram: ram ?? this.ram,
      hardDrive: hardDrive ?? this.hardDrive,
      typeHardDrive: typeHardDrive ?? this.typeHardDrive,
      graphicsCard: graphicsCard ?? this.graphicsCard,
      statusLaptop: statusLaptop ?? this.statusLaptop,
      guarantee: guarantee ?? this.guarantee,
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
      'microprocessor': microprocessor,
      'ram': ram,
      'hardDrive': hardDrive,
      'typeHardDrive': typeHardDrive,
      'graphicsCard': graphicsCard,
      'statusLaptop': statusLaptop,
      'guarantee': guarantee,
      'price': price,
    };
  }

  factory PostLaptopModel.fromMap(Map<String, dynamic> map) {
    return PostLaptopModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      address: AddressModel.fromMap(map['address']),
      brand: map['brand'] ?? '',
      color: map['color'] ?? '',
      microprocessor: map['microprocessor'] ?? '',
      ram: map['ram'] ?? '',
      hardDrive: map['hardDrive'] ?? '',
      typeHardDrive: map['typeHardDrive'] ?? '',
      graphicsCard: map['graphicsCard'] ?? '',
      statusLaptop: map['statusLaptop'] ?? '',
      guarantee: map['guarantee'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostLaptopModel.fromJson(String source) =>
      PostLaptopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostLaptopModel(id: $id, typePost: $typePost, address: $address, brand: $brand, color: $color, microprocessor: $microprocessor, ram: $ram, hardDrive: $hardDrive, typeHardDrive: $typeHardDrive, graphicsCard: $graphicsCard, statusLaptop: $statusLaptop, guarantee: $guarantee, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostLaptopModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.address == address &&
        other.brand == brand &&
        other.color == color &&
        other.microprocessor == microprocessor &&
        other.ram == ram &&
        other.hardDrive == hardDrive &&
        other.typeHardDrive == typeHardDrive &&
        other.graphicsCard == graphicsCard &&
        other.statusLaptop == statusLaptop &&
        other.guarantee == guarantee &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        address.hashCode ^
        brand.hashCode ^
        color.hashCode ^
        microprocessor.hashCode ^
        ram.hashCode ^
        hardDrive.hashCode ^
        typeHardDrive.hashCode ^
        graphicsCard.hashCode ^
        statusLaptop.hashCode ^
        guarantee.hashCode ^
        price.hashCode;
  }
}
