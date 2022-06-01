import 'dart:async';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/list_empty_widget.dart';
import 'package:chotot_app/src/widgets/post_widget_ver_paymet.dart';
import 'package:flutter/material.dart';

class ShowingPostScreen extends StatefulWidget {
  const ShowingPostScreen({Key? key}) : super(key: key);
  // final StreamController<List<PostModel>> postShowingController;

  @override
  State<ShowingPostScreen> createState() => _ShowingPostScreenState();
}

class _ShowingPostScreenState extends State<ShowingPostScreen> {
  StreamController<List<PostModel>> postShowingController =
      StreamController<List<PostModel>>.broadcast();
  loadData() async {
    try {
      var result = await PostServiceRepository()
          .getAllPostAuth(page: 0, limit: 10, status: 2);
      if (result.length == 0) {
        postShowingController.add([]);
      } else {
        postShowingController.sink.add(result);
      }
    } catch (err) {
      // widget.postShowingController.addError("error");
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    postShowingController.close();

    super.dispose();
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
                  "Đang hiển thị",
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
                stream: postShowingController.stream,
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
                              return PostWidgetpayment(
                                postData: snapshot.data![index],
                                postShowingController: postShowingController,

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
