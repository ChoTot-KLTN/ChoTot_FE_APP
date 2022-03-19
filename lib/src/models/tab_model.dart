import 'dart:convert';

import 'package:flutter/cupertino.dart';

class TabModel {
  final String title;
  final IconData icon;
  final double width;
  TabModel({
    required this.title,
    required this.icon,
    required this.width,
  });

  TabModel copyWith({
    String? title,
    IconData? icon,
    double? width,
  }) {
    return TabModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon.codePoint,
      'width': width,
    };
  }

  factory TabModel.fromMap(Map<String, dynamic> map) {
    return TabModel(
      title: map['title'] ?? '',
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      width: map['width']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TabModel.fromJson(String source) =>
      TabModel.fromMap(json.decode(source));

  @override
  String toString() => 'TabModel(title: $title, icon: $icon, width: $width)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TabModel &&
        other.title == title &&
        other.icon == icon &&
        other.width == width;
  }

  @override
  int get hashCode => title.hashCode ^ icon.hashCode ^ width.hashCode;
}
