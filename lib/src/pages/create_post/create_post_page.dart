import 'package:chotot_app/src/pages/create_post/components/create_post_BDS.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tạo bài đăng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              ExpansionTile(
                title: Text(
                  "Bất động sản",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.house),
                children: [
                  ListTile(
                      title: Text("Căn hộ/chung cư"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {
                        Get.to(() => CreatePostBDSScreen());
                      }),
                  ListTile(
                      title: Text("Nhà ở"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Đất"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Văn phòng, mặt bằng kinh doanh"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Phòng trọ"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Xe cộ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.car_rental),
                children: [
                  ListTile(
                      title: Text("Ô tô"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Xe máy"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Xe tải, xe ben"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Xe điện"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Xe đạp"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("Phương tiện khác"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Đồ điện tử",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.phone_iphone),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Thú cưng",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.pets),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Đồ ăn, thực phẩm và các loại khác",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.fastfood),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Tủ lạnh, máy lạnh, máy giặt",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.air_sharp),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Thời trang, đồ dùng cá nhân",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.dry_cleaning_rounded),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Giải trí, thể thao, sở thích",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.sports),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Đồ dùng văn phòng, công nông nghiệp",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.table_view),
                children: [],
              ),
              ExpansionTile(
                title: Text(
                  "Dịch vụ, Du lịch",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.travel_explore),
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
