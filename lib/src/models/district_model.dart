import 'dart:convert';

class DistrictModel {
  final String code;
  final String nameWithType;
  DistrictModel({
    required this.code,
    required this.nameWithType,
  });

  DistrictModel copyWith({
    String? code,
    String? nameWithType,
  }) {
    return DistrictModel(
      code: code ?? this.code,
      nameWithType: nameWithType ?? this.nameWithType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'nameWithType': nameWithType,
    };
  }

  factory DistrictModel.fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      code: map['code'],
      nameWithType: map['name_with_type'],
    );
  }

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
        code: json['code'], nameWithType: json['name_with_type']);
  }

  static List<DistrictModel> fromJsonList(List list) {
    return list.map((e) => DistrictModel.fromJson(e)).toList();
  }

  bool isEqual(DistrictModel model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => nameWithType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DistrictModel &&
        other.code == code &&
        other.nameWithType == nameWithType;
  }

  @override
  int get hashCode => code.hashCode ^ nameWithType.hashCode;
}
