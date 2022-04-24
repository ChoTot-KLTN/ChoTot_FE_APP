import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostBycleModel {
  String id;
  String typePost;
  String type;
  AddressModel address;
  String brand;
  String typeBicycle;
  String engine;
  String statusBicycle;
  String guarantee;
  int price;
  PostBycleModel({
    required this.id,
    required this.typePost,
    required this.type,
    required this.address,
    required this.brand,
    required this.typeBicycle,
    required this.engine,
    required this.statusBicycle,
    required this.guarantee,
    required this.price,
  });

  PostBycleModel copyWith({
    String? id,
    String? typePost,
    String? type,
    AddressModel? address,
    String? brand,
    String? typeBicycle,
    String? engine,
    String? statusBicycle,
    String? guarantee,
    int? price,
  }) {
    return PostBycleModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      type: type ?? this.type,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      typeBicycle: typeBicycle ?? this.typeBicycle,
      engine: engine ?? this.engine,
      statusBicycle: statusBicycle ?? this.statusBicycle,
      guarantee: guarantee ?? this.guarantee,
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
      'typeBicycle': typeBicycle,
      'engine': engine,
      'statusBicycle': statusBicycle,
      'guarantee': guarantee,
      'price': price,
    };
  }

  factory PostBycleModel.fromMap(Map<String, dynamic> map) {
    return PostBycleModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      type: map['type'] ?? '',
      address: AddressModel.fromMap(map['address']),
      brand: map['brand'] ?? '',
      typeBicycle: map['typeBicycle'] ?? '',
      engine: map['engine'] ?? '',
      statusBicycle: map['statusBicycle'] ?? '',
      guarantee: map['guarantee'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostBycleModel.fromJson(String source) =>
      PostBycleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostBycleModel(id: $id, typePost: $typePost, type: $type, address: $address, brand: $brand, typeBicycle: $typeBicycle, engine: $engine, statusBicycle: $statusBicycle, guarantee: $guarantee, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostBycleModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.type == type &&
        other.address == address &&
        other.brand == brand &&
        other.typeBicycle == typeBicycle &&
        other.engine == engine &&
        other.statusBicycle == statusBicycle &&
        other.guarantee == guarantee &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typePost.hashCode ^
        type.hashCode ^
        address.hashCode ^
        brand.hashCode ^
        typeBicycle.hashCode ^
        engine.hashCode ^
        statusBicycle.hashCode ^
        guarantee.hashCode ^
        price.hashCode;
  }
}
