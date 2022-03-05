import 'dart:convert';

class Village {
  final String code;
  final String nameWithType;
  Village({
    required this.code,
    required this.nameWithType,
  });

  Village copyWith({
    String? code,
    String? nameWithType,
  }) {
    return Village(
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

  factory Village.fromMap(Map<String, dynamic> map) {
    return Village(
      code: map['code'],
      nameWithType: map['name_with_type'],
    );
  }

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(code: json['code'], nameWithType: json['name_with_type']);
  }

  static List<Village> fromJsonList(List list) {
    return list.map((e) => Village.fromJson(e)).toList();
  }

  bool isEqual(Village model) {
    return this.code == model.code;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => nameWithType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Village &&
        other.code == code &&
        other.nameWithType == nameWithType;
  }

  @override
  int get hashCode => code.hashCode ^ nameWithType.hashCode;
}
