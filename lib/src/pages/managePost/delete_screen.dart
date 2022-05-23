import 'dart:async';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/list_empty_widget.dart';
import 'package:chotot_app/src/widgets/post_widget_ver_delete.dart';
import 'package:flutter/material.dart';

class DeletePostScreen extends StatefulWidget {
  const DeletePostScreen({Key? key, required this.postDeleteController})
      : super(key: key);
  final StreamController<List<PostModel>> postDeleteController;

  @override
  State<DeletePostScreen> createState() => _DeletePostScreenState();
}

class _DeletePostScreenState extends State<DeletePostScreen> {
  loadData() async {
    try {
      var result = await PostServiceRepository()
          .getAllPostAuth(page: 0, limit: 10, status: 3);
      if (result.length == 0) {
        widget.postDeleteController.add([]);
      } else {
        widget.postDeleteController.add(result);
      }
    } catch (err) {
      // widget.postDeleteController.addError("error");
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Đã hủy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Container(
              // height: 500,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: StreamBuilder<List<PostModel>>(
                stream: widget.postDeleteController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.length == 0
                        ? Center(
                            child: ListEmptyWidget(
                              status: "Không có tin đăng nào",
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(bottom: 40),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (cotext, index) {
                              return PostDeleteWidgetVer(
                                postData: snapshot.data![index],
                              );
                            },
                            itemCount: snapshot.data!.length,
                          );
                  }
                  if (snapshot.hasError) {
                    Center(
                      child: Text("Lỗi"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
