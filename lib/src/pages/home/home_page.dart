import 'package:carousel_slider/carousel_slider.dart';
import 'package:chotot_app/src/models/category_model.dart';
import 'package:chotot_app/src/pages/home/components/item_news.dart';
import 'package:chotot_app/src/pages/home/components/item_post.dart';
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

  List<CategoryModel> listCategory = [
    CategoryModel(
        id: '1',
        name: "Bất động sản",
        description: "kinh doanh BĐS",
        image:
            'https://i.pinimg.com/originals/63/f9/34/63f93438a3fae83d867938cb1adfef4f.png'),
    CategoryModel(
        id: '2',
        name: "Xe cộ",
        description: "kinh doanh BĐS",
        image:
            'https://image-us.24h.com.vn/upload/4-2021/images/2021-10-19/Top-xe-o-to-vua-dep-vua-re-dang-ban-rat-chay-tai-thi-truong-Viet-Nam-2021-1-1634629692-968-width700height467.jpeg'),
    CategoryModel(
        id: '3',
        name: "Đồ điện tử",
        description: "kinh doanh BĐS",
        image:
            'https://cdn.tgdd.vn/Files/2019/12/30/1229107/5-cach-khac-phuc-man-hinh-cam-ung-tren-dien-thoai-khong-bam-duoc-10.jpg'),
    CategoryModel(
        id: '4',
        name: "Đồ gia dụng",
        description: "kinh doanh BĐS",
        image:
            'https://www.goxanh.vn/image/data/go-xanh/hinh-anh-bo-ghe-salon-co-dien-dep-2.jpg'),
    CategoryModel(
        id: '5',
        name: "Giải trí, Thể thao",
        description: "kinh doanh BĐS",
        image:
            'https://nhaccuvuuyen.vn/wp-content/uploads/2017/03/nhung-cach-giam-dau-hieu-qua-khi-choi-dan-guitar.jpg'),
    CategoryModel(
        id: '6',
        name: "Mẹ và bé",
        description: "kinh doanh BĐS",
        image:
            'http://file.hstatic.net/200000232569/collection/me_va_be_101faed2b2154c44a23ae81e686d1845.jpg'),
    CategoryModel(
        id: '7',
        name: "Thú cưng",
        description: "kinh doanh BĐS",
        image:
            'https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313__480.jpg'),
    CategoryModel(
        id: '8',
        name: "Thời trang",
        description: "kinh doanh BĐS",
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXx7cAOxe4__rlYXDzbSbXW_1wOu74eHJtpA&usqp=CAU'),
    CategoryModel(
        id: '9',
        name: "Đồ văn phòng",
        description: "kinh doanh BĐS",
        image:
            'https://dplusvn.com/wp-content/uploads/2020/06/van-phong-d.jpg'),
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
        automaticallyImplyLeading: false, // bỏ nút back
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
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
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

            buildDevider(Colors.black12, 0, 0, 6, 16),
            // SizedBox(
            //   height: 16,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "khám phá danh mục",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                height: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width - 20,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ItemPostWidget(
                      categoryModel: listCategory[index],
                    );
                  },
                  itemCount: listCategory.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            buildDevider(Colors.black12, 0, 0, 6, 16),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                child: Row(
                  children: [
                    Text(
                      "Chợ HD có gì mới",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                height: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset(
                    'assets/images/chotohd.png',
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(height: 15),
          ],
        ),
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

class ItemNews {
  final Color color;
  final IconData iconData;
  final String title;

  ItemNews({required this.color, required this.iconData, required this.title});
}
