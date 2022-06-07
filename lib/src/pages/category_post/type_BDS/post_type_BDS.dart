import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chotot_app/src/models/item_new.dart';
import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/components/apartment_screen.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/components/ground_screen.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/components/house_screen.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/components/motel_room_screen.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/components/office_screen.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/item_BDS.dart';

import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/base_widget.dart';
import 'package:chotot_app/src/widgets/post_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostTypeBDSScreen extends StatefulWidget {
  const PostTypeBDSScreen({Key? key}) : super(key: key);

  @override
  State<PostTypeBDSScreen> createState() => _PostTypeBDSScreenState();
}

class _PostTypeBDSScreenState extends State<PostTypeBDSScreen> {
  TextEditingController search = TextEditingController();
  static const imgList = [
    'assets/banner/bannerbdsa.jpg',
    'assets/banner/bannerbdsb.jpg',
    'assets/banner/bannerbdsc.jpg',
  ];
  StreamController<List<PostModel>> streamCategoryController =
      StreamController<List<PostModel>>();
  StreamController<List<PostModel>> streamCategoryLastController =
      StreamController<List<PostModel>>();
  List<PostModel> listTemp = [];
  int current = 0;
  List<ItemNews> listNews = [
    ItemNews(
        color: Colors.white,
        iconData: Icons.apartment_outlined,
        title: "Căn hộ/chung cư",
        function: () {
          Get.to(() => ApartmentScreen());
        }),
    ItemNews(
        color: Colors.white,
        iconData: Icons.house_outlined,
        title: "Nhà ở",
        function: () {
          Get.to(() => HouseScreen());
        }),
    ItemNews(
        color: Colors.white,
        iconData: Icons.house_sharp,
        title: "Nhà trọ",
        function: () {
          Get.to(() => MotelRoomScreen());
        }),
    ItemNews(
        color: Colors.white,
        iconData: Icons.golf_course_outlined,
        title: "Đất",
        function: () {
          Get.to(() => GroundScreen());
        }),
    ItemNews(
        color: Colors.white,
        iconData: Icons.location_city,
        title: "Mặt bằng",
        function: () {
          Get.to(() => OfficeScreen());
        }),
  ];

  final CarouselController _controller = CarouselController();

  loadData() async {
    var result1 = await PostServiceRepository()
        .getAllPostWithCategoryBDSPriority(page: 0, limit: 10);
    if (result1.length == 0) {
      streamCategoryController.add([]);
    } else {
      // streamCategoryController.add(result);
      listTemp.addAll(result1);
    }
    var result = await PostServiceRepository()
        .getAllPostWithCategoryBDS(page: 0, limit: 10);
    if (result.length == 0) {
      streamCategoryController.add([]);
    } else {
      listTemp.addAll(result);
      streamCategoryController.add(listTemp);
    }
  }

  loadDatalast() async {
    var result = await PostServiceRepository()
        .getAllPostWithCategoryBDSLast(page: 0, limit: 10);
    if (result.length == 0) {
      streamCategoryLastController.add([]);
    } else {
      // listTemp.addAll(result);
      streamCategoryLastController.add(result);
    }
  }

  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'Chợ Tốt HD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    loadData();
    loadDatalast();
  }

  @override
  void dispose() {
    streamCategoryController.close();
    streamCategoryLastController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                },
              ),
              carouselController: _controller,
              items: imageSliders,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "Danh mục thiết bị điện tử",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                height: 50,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              height: 120,
              //width: 85,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ItemBDSWidget(
                    color: listNews[index].color,
                    iconData: listNews[index].iconData,
                    title: listNews[index].title,
                    function: listNews[index].function,
                  );
                },
                itemCount: listNews.length,
                scrollDirection: Axis.horizontal,
              ),
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
              // height: 500,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: StreamBuilder<List<PostModel>>(
                stream: streamCategoryController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.length == 0
                        ? Center(
                            child: Text("Không có tin đăng nào"),
                          )
                        : GridView.builder(
                            // controller: scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 8.0,
                                    mainAxisExtent: 330),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return PostCard(
                                postData: snapshot.data![index],
                              );
                            },
                            itemCount:
                                snapshot.data!.length, //listDataProduct.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
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
            SizedBox(
              height: 20,
            ),
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
            buildDevider(Colors.black12, 0, 0, 6, 16),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "Tin đăng mới nhất",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                height: 50,
              ),
            ),
            Container(
                height: 350,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                child: StreamBuilder<List<PostModel>>(
                  stream: streamCategoryLastController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.length == 0
                          ? Center(
                              child: Text("không có tin đăng nào"),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return PostCard(
                                  postData: snapshot.data![index],
                                );
                              },
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
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
              height: 20,
            ),
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
            SizedBox(
              height: 50,
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
}
