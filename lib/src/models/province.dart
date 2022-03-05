import 'dart:convert';

class Province {
  final String name;
  final String name_with_type;
  final String type;
  final String code;
  Province(
      {required this.name,
      required this.name_with_type,
      required this.type,
      required this.code});

  Province copyWith({
    String? name,
    String? name_with_type,
    String? type,
    String? code,
  }) {
    return Province(
      name: name ?? this.name,
      name_with_type: name_with_type ?? this.name_with_type,
      type: type ?? this.type,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'name_with_type': name_with_type,
      'type': type,
      'code': code,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      name: map['name'],
      name_with_type: map['name_with_type'],
      type: map['type'],
      code: map['code'],
    );
  }

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
        name: json['name'],
        name_with_type: json['name_with_type'],
        type: json['type'],
        code: json['code']);
  }
  static List<Province> fromJsonList(List list) {
    return list.map((e) => Province.fromJson(e)).toList();
  }

  bool isEqual(Province model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return name_with_type;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Province &&
        other.name == name &&
        other.name_with_type == name_with_type &&
        other.type == type &&
        other.code == code;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        name_with_type.hashCode ^
        type.hashCode ^
        code.hashCode;
  }
}
