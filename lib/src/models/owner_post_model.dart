import 'dart:convert';

import 'package:chotot_app/src/models/user_model.dart';

class OwnerPostModel {
  final UserModel infor;
  final double totalRate;
  final int count;
  OwnerPostModel({
    required this.infor,
    required this.totalRate,
    required this.count,
  });

  OwnerPostModel copyWith({
    UserModel? infor,
    double? totalRate,
    int? count,
  }) {
    return OwnerPostModel(
      infor: infor ?? this.infor,
      totalRate: totalRate ?? this.totalRate,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'infor': infor.toMap(),
      'totalRate': totalRate,
      'count': count,
    };
  }

  factory OwnerPostModel.fromMap(Map<String, dynamic> map) {
    return OwnerPostModel(
      infor: UserModel.fromMap(map['infor']),
      totalRate: double.parse((map['totalRate']).toString()),
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OwnerPostModel.fromJson(String source) =>
      OwnerPostModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'OwnerPostModel(infor: $infor, totalRate: $totalRate, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OwnerPostModel &&
        other.infor == infor &&
        other.totalRate == totalRate &&
        other.count == count;
  }

  @override
  int get hashCode => infor.hashCode ^ totalRate.hashCode ^ count.hashCode;
}
