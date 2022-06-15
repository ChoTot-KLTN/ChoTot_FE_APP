import 'dart:convert';

class RatingModel {
  final double rate;
  final int count;
  RatingModel({
    required this.rate,
    required this.count,
  });

  RatingModel copyWith({
    double? rate,
    int? count,
  }) {
    return RatingModel(
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      rate: map['rate']?.toDouble() ?? 0.0,
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) =>
      RatingModel.fromMap(json.decode(source));

  @override
  String toString() => 'RatingModel(rate: $rate, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RatingModel && other.rate == rate && other.count == count;
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
}
