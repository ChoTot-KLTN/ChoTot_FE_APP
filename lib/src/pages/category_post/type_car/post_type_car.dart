import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chotot_app/src/models/item_new.dart';
import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/pages/category_post/type_car/item_car.dart';
import 'package:chotot_app/src/pages/home/components/item_news.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/base_widget.dart';

import 'package:flutter/material.dart';

class PostTypeCarScreen extends StatefulWidget {
  const PostTypeCarScreen({Key? key}) : super(key: key);

  @override
  State<PostTypeCarScreen> createState() => _PostTypeCarScreenState();
}

class _PostTypeCarScreenState extends State<PostTypeCarScreen> {
  TextEditingController search = TextEditingController();
  static const imgList = [
    'assets/banner/bannercara.jpg',
    'assets/banner/bannercarb.jpg',
    'assets/banner/bannercarc.jpg',
  ];
  StreamController<List<PostModel>> stream =
      StreamController<List<PostModel>>();
  int current = 0;
  List<ItemNews> listNews = [
    ItemNews(
        color: Colors.white,
        iconData: Icons.car_rental_outlined,
        title: "Ô tô",
        function: () {
          print("Ô tô");
        }),
    ItemNews(
        color: Colors.white,
        iconData: Icons.motorcycle_rounded,
        title: "Xe máy",
        function: () {
          print("Xe máy");
        }),
    ItemNews(
        color: Colors.white,
        iconData: Icons.electric_moped_outlined,
        title: "Xe điện",
        function: () {
          print("Xe điện");
        }),
  ];
  List<ItemNews> listNews2 = [
    ItemNews(
        color: Colors.green.shade500,
        iconData: Icons.car_repair_outlined,
        title: "Kiểm định xe cũ",
        function: () {
          print("ưu đãi");
        }),
    ItemNews(
        color: Colors.pink,
        iconData: Icons.electric_car,
        title: "Định giá bán xe",
        function: () {
          print("đã lưu");
        }),
    ItemNews(
        color: Colors.blue.shade500,
        iconData: Icons.new_label_outlined,
        title: "Trang tin xe",
        function: () {
          print("tìm đã lưu");
        }),
  ];
  final CarouselController _controller = CarouselController();
  loadData() async {
    var result = await PostServiceRepository().getAllPost(page: 0, limit: 10);
    if (result.length == 0) {
      stream.add([]);
    } else {
      stream.add(result);
    }
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
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
          ))
      .toList();

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  @override
  void dispose() {
    stream.close();
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
                      "Khám phá danh mục xe cộ",
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
              // height: 120,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ItemCarsWidget(
                    color: listNews[0].color,
                    iconData: listNews[0].iconData,
                    title: listNews[0].title,
                  ),
                  ItemCarsWidget(
                    color: listNews[1].color,
                    iconData: listNews[1].iconData,
                    title: listNews[1].title,
                  ),
                  ItemCarsWidget(
                    color: listNews[2].color,
                    iconData: listNews[2].iconData,
                    title: listNews[2].title,
                  )
                ],
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
            SizedBox(
              height: 180,
              child: Text("Hiển thị tin từ API"),
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
            SizedBox(
              height: 180,
              child: Text("Hiển thị tin từ API"),
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
                      "Công cụ mua bán",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                height: 50,
              ),
            ),
            Container(
              // height: 120,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ItemNewsWidget(
                    color: listNews2[0].color,
                    iconData: listNews2[0].iconData,
                    title: listNews2[0].title,
                  ),
                  ItemNewsWidget(
                    color: listNews2[1].color,
                    iconData: listNews2[1].iconData,
                    title: listNews2[1].title,
                  ),
                  ItemNewsWidget(
                    color: listNews2[2].color,
                    iconData: listNews2[2].iconData,
                    title: listNews2[2].title,
                  ),
                ],
              ),
            ),
            buildDevider(Colors.black12, 0, 0, 6, 16),
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
