import 'dart:async';

import 'package:chotot_app/src/models/favorite_post_model.dart';
import 'package:chotot_app/src/repositories/favorite_repo.dart';
import 'package:chotot_app/src/widgets/favorite_post_widget.dart';
import 'package:chotot_app/src/widgets/list_empty_widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key, required this.favoritePostController})
      : super(key: key);
  final StreamController<List<FavoritePostModel>> favoritePostController;
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  loadData() async {
    try {
      var result = await FavoriteRepository().getAllPostRegister();
      if (result!.length == 0) {
        widget.favoritePostController.add([]);
      } else {
        widget.favoritePostController.add(result);
      }
    } catch (err) {
      // widget.postRejectController.addError("error");
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
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
                  "Bài đăng yêu thích",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 10.0),
            child: Container(
              // height: 500,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: StreamBuilder<List<FavoritePostModel>>(
                stream: widget.favoritePostController.stream,
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
                              return PostwidgetFavorite(
                                  postData: snapshot.data![index].postId,
                                  postFavoriteController:
                                      widget.favoritePostController,
                                  idFavorite: snapshot.data![index].id
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
