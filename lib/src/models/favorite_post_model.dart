import 'dart:convert';

import 'package:chotot_app/src/models/post/post_model.dart';

class FavoritePostModel {
  String id;
  PostModel postId;
  String idUser;
  bool isActive;
  FavoritePostModel({
    required this.id,
    required this.postId,
    required this.idUser,
    required this.isActive,
  });

  FavoritePostModel copyWith({
    String? id,
    PostModel? postId,
    String? idUser,
    bool? isActive,
  }) {
    return FavoritePostModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      idUser: idUser ?? this.idUser,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId.toMap(),
      'idUser': idUser,
      'isActive': isActive,
    };
  }

  factory FavoritePostModel.fromMap(Map<String, dynamic> map) {
    return FavoritePostModel(
      id: map['_id'] ?? '',
      postId: PostModel.fromMap(map['postId']),
      idUser: map['idUser'] ?? '',
      isActive: map['isActive'] ?? false,
    );
  }

  static List<FavoritePostModel> fromJsonList(List list) {
    return list.map((e) => FavoritePostModel.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory FavoritePostModel.fromJson(String source) =>
      FavoritePostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FavoritePostModel(id: $id, postId: $postId, idUser: $idUser, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoritePostModel &&
        other.id == id &&
        other.postId == postId &&
        other.idUser == idUser &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^ postId.hashCode ^ idUser.hashCode ^ isActive.hashCode;
  }
}
