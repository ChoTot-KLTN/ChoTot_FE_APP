import 'dart:async';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/list_empty_widget.dart';
import 'package:chotot_app/src/widgets/post_widget_ver_overtime.dart';
import 'package:flutter/material.dart';

class OvertimePostScreen extends StatefulWidget {
  const OvertimePostScreen({Key? key, required this.postOvertimeController})
      : super(key: key);
  final StreamController<List<PostModel>> postOvertimeController;

  @override
  State<OvertimePostScreen> createState() => _OvertimePostScreenState();
}

class _OvertimePostScreenState extends State<OvertimePostScreen> {
  loadData() async {
    try {
      var result = await PostServiceRepository()
          .getAllPostOvertime(page: 0, limit: 10, status: 2);
      if (result.length == 0) {
        widget.postOvertimeController.add([]);
      } else {
        widget.postOvertimeController.add(result);
      }
    } catch (err) {
      // widget.postOvertimeController.addError("error");
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    // if (widget.postOvertimeController != null) {
    //   widget.postOvertimeController.close();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Đã hết hạn",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 10.0),
            child: Container(
              // height: 500,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: StreamBuilder<List<PostModel>>(
                stream: widget.postOvertimeController.stream,
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
                              return PostwidgetOverTime(
                                postData: snapshot.data![index],
                                postOvertimeController:
                                    widget.postOvertimeController,
                                // loadData: loadData(),
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
