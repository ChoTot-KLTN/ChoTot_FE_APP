import 'dart:async';

import 'package:chotot_app/src/common/common_const.dart';
import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';

import 'package:chotot_app/src/widgets/flitter_BDS.dart';
import 'package:chotot_app/src/widgets/post_widget_ver_s.dart';
import 'package:flutter/material.dart';
import 'package:chotot_app/src/common/base_convert.dart';

class MotelRoomScreen extends StatefulWidget {
  MotelRoomScreen({Key? key}) : super(key: key);

  @override
  State<MotelRoomScreen> createState() => _MotelRoomScreenState();
}

class _MotelRoomScreenState extends State<MotelRoomScreen> {
  TextEditingController search = TextEditingController();
  String provice = listProvince[0];
  int startPrice = 0;
  int endPrice = 10000000;
  double startArea = 0;
  double endArea = 10000;
  StreamController<List<PostModel>> listPostController =
      StreamController<List<PostModel>>();
  StreamController<List<PostModel>> listPostPreorityController =
      StreamController<List<PostModel>>();
  List<PostModel> listTemp = [];

  callback(priceMax, priceMin, endAreas, startAreas) {
    setState(() {
      startPrice = priceMin;
      endPrice = priceMax;
      endArea = endAreas;
      startArea = startAreas;
    });
  }

  loadData() async {
    var listPostPreority = await PostServiceRepository()
        .getAllPostWithTypePreority(
            page: 0, limit: 10, status: 2, type: "PostMotelRoom");
    if (listPostPreority.length == 0) {
      listPostPreorityController.add([]);
    } else {
      listTemp.addAll(listPostPreority);
      listPostPreorityController.add(listPostPreority);
    }
    var listPost = await PostServiceRepository().getAllPostWithType(
        page: 0, limit: 10, status: 2, type: "PostMotelRoom");
    if (listPost.length == 0) {
      listPostController.add([]);
    } else {
      // listPostController.add(listTemp);
      listTemp.addAll(listPost);
      listPostController.add(listTemp);
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    listPostController.close();
    listPostPreorityController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: buildSearch(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                size: 30,
              ))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Text(
                    "Khu vực",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    child: DropdownButton(
                      menuMaxHeight: size.width,
                      underline: SizedBox(),
                      isExpanded: false,
                      value: provice,
                      onChanged: (value) {
                        setState(() {
                          provice = value.toString();
                        });
                      },
                      items: listProvince.map((e) {
                        return DropdownMenuItem(
                          child: new Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: [
                  FilterBDSScreen(
                    callBackFunc: callback,
                    typePost: "Apartment",
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 18, right: 10),
                      child: Text(
                          "Giá: ${startPrice.toString().toVND()} - ${endPrice.toString().toVND()}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500))),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 18, right: 10),
                      child: Text(
                          "Diện tích: ${startArea.round().toString()} - ${endArea.round().toString()} /m2",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)))
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            buildDevider(Colors.black12, 0, 0, 6, 16),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "Tin dành cho bạn",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                height: 50,
              ),
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: StreamBuilder<List<PostModel>>(
                  stream: listPostController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.length == 0
                          ? Center(
                              child: Text("không có tin đăng nào"),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return PostWidgetVerS(
                                  postData: snapshot.data![index],
                                );
                              },
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                            );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Lỗi"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  print("xem thêm");
                },
                child: Text(
                  "Xem thêm >",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildSearch() {
    return Container(
      padding: EdgeInsets.only(right: 3.0),
      height: 48,
      width: MediaQuery.of(context).size.width - 70,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {
                        print("search ne");
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    hintText: "Tìm kiếm"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildDevider(
      Color color, double indent, double endi, double thickness, double h) {
    return Divider(
      color: color,
      indent: indent,
      endIndent: endi,
      thickness: thickness,
      height: h,
    );
  }
}
