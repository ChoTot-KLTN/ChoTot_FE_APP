import 'dart:convert';

import 'package:chotot_app/src/common/base_convert.dart';
import 'package:chotot_app/src/models/user_comment_model.dart';

class CommentModel {
  String id;
  String postId;
  String text;
  bool isDeleted;
  DateTime? createdAt;
  UserComment idUserComment;
  CommentModel({
    required this.id,
    required this.postId,
    required this.text,
    required this.isDeleted,
    this.createdAt,
    required this.idUserComment,
  });

  CommentModel copyWith({
    String? id,
    String? postId,
    String? text,
    bool? isDeleted,
    DateTime? createdAt,
    UserComment? idUserComment,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      text: text ?? this.text,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      idUserComment: idUserComment ?? this.idUserComment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'text': text,
      'isDeleted': isDeleted,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'idUserComment': idUserComment.toMap(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['_id'] ?? '',
      postId: map['postId'] ?? '',
      text: map['text'] ?? '',
      isDeleted: map['isDeleted'] ?? false,
      createdAt: convertTextToDateTime(map['createdAt']) ?? null,
      idUserComment: UserComment.fromMap(map['idUserComment']),
    );
  }

  String toJson() => json.encode(toMap());
  static List<CommentModel> fromJsonList(List list) {
    return list.map((e) => CommentModel.fromMap(e)).toList();
  }

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommentModel(id: $id, postId: $postId, text: $text, isDeleted: $isDeleted, createdAt: $createdAt, idUserComment: $idUserComment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.id == id &&
        other.postId == postId &&
        other.text == text &&
        other.isDeleted == isDeleted &&
        other.createdAt == createdAt &&
        other.idUserComment == idUserComment;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        postId.hashCode ^
        text.hashCode ^
        isDeleted.hashCode ^
        createdAt.hashCode ^
        idUserComment.hashCode;
  }
}
