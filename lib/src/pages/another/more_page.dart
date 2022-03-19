import 'package:chotot_app/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List<ItemNews> listItems = [
    ItemNews(
        color: Colors.green.shade400,
        iconData: Icons.history,
        title: "Đơn hàng đặt cọc"),
    ItemNews(
        color: Colors.pink.shade400,
        iconData: Icons.favorite,
        title: "Tin đăng đã lưu"),
    ItemNews(
        color: Colors.purple.shade400,
        iconData: Icons.flag,
        title: "Tìm kiếm đã lưu"),
    ItemNews(
        color: Colors.blue.shade500,
        iconData: Icons.people_sharp,
        title: "Bạn bè"),
    ItemNews(
        color: Colors.brown.shade500,
        iconData: Icons.history_edu,
        title: "Lịch sử giao dịch"),
    ItemNews(
        color: Colors.brown.shade200,
        iconData: Icons.card_membership,
        title: "Tài khoản nhận thanh toán"),
    ItemNews(
        color: Colors.green.shade500,
        iconData: Icons.star,
        title: "Chợ tốt HD ưu đãi"),
    ItemNews(
        color: Colors.green.shade500,
        iconData: Icons.payment,
        title: "Chợ tốt HD Khuyến mãi"),
    ItemNews(
        color: Colors.grey.shade500, iconData: Icons.help, title: "Trợ giúp"),
    ItemNews(
        color: Colors.grey.shade500,
        iconData: Icons.settings,
        title: "Cài đặt"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black)),
            child: Column(
              children: [
                buildAvatar(),
                SizedBox(
                  height: 30,
                ),
                ListView.builder(
                  itemCount: listItems.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildItem(listItems[index].color,
                        listItems[index].iconData, listItems[index].title);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAvatar() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/avatar.png',
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phùng Vĩnh Đức",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 25,
              ),
              GestureDetector(
                child: Text(
                  "Xem trang cá nhân của bạn",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                onTap: () {
                  print("Xem trang cá nhân");
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildItem(Color color, IconData iconData, String title) {
    return GestureDetector(
      onTap: () {
        print(title);
      },
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: color),
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
