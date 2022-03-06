import 'package:carousel_slider/carousel_slider.dart';
import 'package:chotot_app/src/pages/home/components/item_news.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();
  final CarouselController _controller = CarouselController();
  int current = 0;

  static const imgList = [
    'assets/banner/chotota.png',
    'assets/banner/chototb.png',
    'assets/banner/chototc.png',
    'assets/banner/chototd.png',
  ];

  List<ItemNews> listNews = [
    ItemNews(
        color: Colors.yellow,
        iconData: Icons.notifications,
        title: "Chương trình/ ưu đãi"),
    ItemNews(
        color: Colors.green, iconData: Icons.history, title: "Đơn đặt cọc"),
    ItemNews(
        color: Colors.orange,
        iconData: Icons.card_giftcard,
        title: "Đăng tin cho tặng"),
    ItemNews(
        color: Colors.red.shade500,
        iconData: Icons.car_rental,
        title: "Định giá xe"),
    ItemNews(
        color: Colors.green.shade500,
        iconData: Icons.star_rate,
        title: "Ưu đãi"),
    ItemNews(
        color: Colors.pink, iconData: Icons.favorite, title: "Tin đăng đã lưu"),
    ItemNews(
        color: Colors.blue.shade500,
        iconData: Icons.search,
        title: "Tìm kiếm đã lưu"),
  ];
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearch(),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                size: 30,
              ))
        ],
      ),
      body: ListView(
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
            child: Container(
              height: 120,
              width: 85,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ItemNewsWidget(
                    color: listNews[index].color,
                    iconData: listNews[index].iconData,
                    title: listNews[index].title,
                  );
                },
                itemCount: listNews.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
        ],
      ),
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
        ));
  }
}

class ItemNews {
  final Color color;
  final IconData iconData;
  final String title;

  ItemNews({required this.color, required this.iconData, required this.title});
}
