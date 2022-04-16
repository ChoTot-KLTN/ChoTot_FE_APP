import 'dart:convert';

import 'package:chotot_app/src/models/address_model.dart';

class PostCarModel {
  String id;
  String typePost;
  String type;
  AddressModel address;
  String brand;
  int yearOfManufacture;
  String carGearbox;
  String fuel;
  int numberOfSeat;
  String color;
  String statusCar;
  int numberOfKm;
  int price;
  PostCarModel({
    required this.id,
    required this.typePost,
    required this.type,
    required this.address,
    required this.brand,
    required this.yearOfManufacture,
    required this.carGearbox,
    required this.fuel,
    required this.numberOfSeat,
    required this.color,
    required this.statusCar,
    required this.numberOfKm,
    required this.price,
  });

  PostCarModel copyWith({
    String? id,
    String? typePost,
    String? type,
    AddressModel? address,
    String? brand,
    int? yearOfManufacture,
    String? carGearbox,
    String? fuel,
    int? numberOfSeat,
    String? color,
    String? statusCar,
    int? numberOfKm,
    int? price,
  }) {
    return PostCarModel(
      id: id ?? this.id,
      typePost: typePost ?? this.typePost,
      type: type ?? this.type,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      yearOfManufacture: yearOfManufacture ?? this.yearOfManufacture,
      carGearbox: carGearbox ?? this.carGearbox,
      fuel: fuel ?? this.fuel,
      numberOfSeat: numberOfSeat ?? this.numberOfSeat,
      color: color ?? this.color,
      statusCar: statusCar ?? this.statusCar,
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
      'yearOfManufacture': yearOfManufacture,
      'carGearbox': carGearbox,
      'fuel': fuel,
      'numberOfSeat': numberOfSeat,
      'color': color,
      'statusCar': statusCar,
      'numberOfKm': numberOfKm,
      'price': price,
    };
  }

  factory PostCarModel.fromMap(Map<String, dynamic> map) {
    return PostCarModel(
      id: map['_id'] ?? '',
      typePost: map['typePost'] ?? '',
      type: map['type'] ?? '',
      address: AddressModel.fromMap(map['address']),
      brand: map['brand'] ?? '',
      yearOfManufacture: map['yearOfManufacture']?.toInt() ?? 0,
      carGearbox: map['carGearbox'] ?? '',
      fuel: map['fuel'] ?? '',
      numberOfSeat: map['numberOfSeat']?.toInt() ?? 0,
      color: map['color'] ?? '',
      statusCar: map['statusCar'] ?? '',
      numberOfKm: map['numberOfKm']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostCarModel.fromJson(String source) =>
      PostCarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostCarModel(id: $id, typePost: $typePost, type: $type, address: $address, brand: $brand, yearOfManufacture: $yearOfManufacture, carGearbox: $carGearbox, fuel: $fuel, numberOfSeat: $numberOfSeat, color: $color, statusCar: $statusCar, numberOfKm: $numberOfKm, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostCarModel &&
        other.id == id &&
        other.typePost == typePost &&
        other.type == type &&
        other.address == address &&
        other.brand == brand &&
        other.yearOfManufacture == yearOfManufacture &&
        other.carGearbox == carGearbox &&
        other.fuel == fuel &&
        other.numberOfSeat == numberOfSeat &&
        other.color == color &&
        other.statusCar == statusCar &&
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
        yearOfManufacture.hashCode ^
        carGearbox.hashCode ^
        fuel.hashCode ^
        numberOfSeat.hashCode ^
        color.hashCode ^
        statusCar.hashCode ^
        numberOfKm.hashCode ^
        price.hashCode;
  }
}
