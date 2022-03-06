import 'dart:convert';

class AddressModel {
  final String detail;
  final String village;
  final String district;
  final String province;
  AddressModel({
    required this.detail,
    required this.village,
    required this.district,
    required this.province,
  });

  AddressModel copyWith({
    String? detail,
    String? village,
    String? district,
    String? province,
  }) {
    return AddressModel(
      detail: detail ?? this.detail,
      village: village ?? this.village,
      district: district ?? this.district,
      province: province ?? this.province,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'detail': detail,
      'village': village,
      'district': district,
      'province': province,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      detail: map['detail'] ?? '',
      village: map['village'] ?? '',
      district: map['district'] ?? '',
      province: map['province'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(detail: $detail, village: $village, district: $district, province: $province)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.detail == detail &&
        other.village == village &&
        other.district == district &&
        other.province == province;
  }

  @override
  int get hashCode {
    return detail.hashCode ^
        village.hashCode ^
        district.hashCode ^
        province.hashCode;
  }
}
