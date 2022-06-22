import 'dart:async';

import 'package:chotot_app/src/models/comment_model.dart';
import 'package:chotot_app/src/repositories/comment_repo.dart';
import 'package:chotot_app/src/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatefulWidget {
  const CommentWidget(
      {Key? key,
      required this.commentDetail,
      required this.commentStream,
      required this.postID})
      : super(key: key);
  final CommentModel commentDetail;
  final StreamController<List<CommentModel>> commentStream;
  final String postID;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  getListComment() async {
    var listComment =
        await CommentRepository().getAllComment(postID: widget.postID);
    if (listComment.length == 0) {
      widget.commentStream.add([]);
    } else {
      widget.commentStream.add(listComment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      // height: 100,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.commentDetail.idUserComment.name + "  ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat("HH:mm")
                          .format(widget.commentDetail.createdAt!),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.commentDetail.text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Flexible(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Xóa bình luận",
                      titleStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      backgroundColor: Colors.white,
                      middleText: " ",
                      middleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textConfirm: "OK",
                      textCancel: "Hủy",
                      cancelTextColor: Colors.black38,
                      onConfirm: () async {
                        print("idcomment" + widget.commentDetail.id);
                        var result = await CommentRepository()
                            .deleteComment(idComment: widget.commentDetail.id);
                        if (result.statusCode == 200) {
                          getListComment();
                        } else {
                          showDialoga(
                              title: "Thất bại",
                              subTitle: "Bạn không có quyền hủy",
                              status: "Fail");
                        }
                        Navigator.of(context).pop();
                      },
                      onCancel: () {
                        print("Hủy xóa");
                      });
                },
                icon: Icon(Icons.more_vert),
              ))
        ],
      ),
    );
  }
}
