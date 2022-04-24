import 'dart:convert';

import 'package:chotot_app/src/common/base_convert.dart';
import 'package:flutter/foundation.dart';

class PostModel {
  String id;
  String title;
  String content;
  List<String> image;
  String typePost;
  String onModel;
  int status;
  int ratings;
  String idUserPost;
  bool isAdvertised;
  int priceAdvert;
  int totalPrice;
  DateTime? dateStartPost;
  DateTime? dateEndPost;
  int prePrice;
  String province;
  String nameOfPoster;
  PostModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.image,
      required this.typePost,
      required this.onModel,
      required this.status,
      required this.ratings,
      required this.idUserPost,
      required this.isAdvertised,
      required this.priceAdvert,
      required this.totalPrice,
      required this.dateStartPost,
      required this.dateEndPost,
      required this.prePrice,
      required this.province,
      required this.nameOfPoster});

  PostModel copyWith(
      {String? id,
      String? title,
      String? content,
      List<String>? image,
      String? typePost,
      String? onModel,
      int? status,
      int? ratings,
      String? idUserPost,
      bool? isAdvertised,
      int? priceAdvert,
      int? totalPrice,
      DateTime? dateStartPost,
      DateTime? dateEndPost,
      int? prePrice,
      String? province,
      String? nameOfPoster}) {
    return PostModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        image: image ?? this.image,
        typePost: typePost ?? this.typePost,
        onModel: onModel ?? this.onModel,
        status: status ?? this.status,
        ratings: ratings ?? this.ratings,
        idUserPost: idUserPost ?? this.idUserPost,
        isAdvertised: isAdvertised ?? this.isAdvertised,
        priceAdvert: priceAdvert ?? this.priceAdvert,
        totalPrice: totalPrice ?? this.totalPrice,
        dateStartPost: dateStartPost ?? this.dateStartPost,
        dateEndPost: dateEndPost ?? this.dateEndPost,
        prePrice: prePrice ?? this.prePrice,
        province: province ?? this.province,
        nameOfPoster: nameOfPoster ?? this.nameOfPoster);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'typePost': typePost,
      'onModel': onModel,
      'status': status,
      'ratings': ratings,
      'idUserPost': idUserPost,
      'isAdvertised': isAdvertised,
      'priceAdvert': priceAdvert,
      'totalPrice': totalPrice,
      'dateStartPost': dateStartPost,
      'dateEndPost': dateEndPost,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        id: map['_id'] ?? '',
        title: map['title'] ?? '',
        content: map['content'] ?? '',
        image: List<String>.from(map['image']),
        typePost: map['typePost'] ?? '',
        onModel: map['onModel'] ?? '',
        status: map['status']?.toInt() ?? 0,
        ratings: map['ratings']?.toInt() ?? 0,
        idUserPost: map['idUserPost'] ?? '',
        isAdvertised: map['isAdvertised'] ?? false,
        priceAdvert: map['priceAdvert']?.toInt() ?? 0,
        totalPrice: map['totalPrice']?.toInt() ?? 0,
        dateStartPost: convertTextToDateTime(map['dateStartPost']) ?? null,
        dateEndPost: convertTextToDateTime(map['dateEndPost']) ?? null,
        prePrice: map['prePrice']?.toInt() ?? 0,
        province: map['province'] ?? '',
        nameOfPoster: map['nameOfPoster'] ?? '');
  }

  static List<PostModel> fromJsonList(List list) {
    return list.map((e) => PostModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, content: $content, image: $image, typePost: $typePost, onModel: $onModel, status: $status, ratings: $ratings, idUserPost: $idUserPost, isAdvertised: $isAdvertised, priceAdvert: $priceAdvert, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        listEquals(other.image, image) &&
        other.typePost == typePost &&
        other.onModel == onModel &&
        other.status == status &&
        other.ratings == ratings &&
        other.idUserPost == idUserPost &&
        other.isAdvertised == isAdvertised &&
        other.priceAdvert == priceAdvert &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        image.hashCode ^
        typePost.hashCode ^
        onModel.hashCode ^
        status.hashCode ^
        ratings.hashCode ^
        idUserPost.hashCode ^
        isAdvertised.hashCode ^
        priceAdvert.hashCode ^
        totalPrice.hashCode;
  }
}
