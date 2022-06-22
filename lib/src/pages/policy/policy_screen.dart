import 'package:flutter/material.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Chích sách ChoTotHD',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: ListView(
            children: [
              ExpansionTile(
                title: Text(
                  "Giao dịch",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.local_police_outlined),
                children: [
                  ListTile(
                      title: Text(
                          "1. Các bện giao dịch một cách tự nguyện\nChoTotHD không liên can"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                          "2. Tự bảo mật thông tin, tiền bạc khi thực hiện giao dịch"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Tạo bài đăng",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.bookmark_add_outlined),
                children: [
                  ListTile(
                      title: Text(
                          "1. Tiêu đề bài đăng không chứa nội dung nhạy cảm hoặc mang tính kích động cộng đồng"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                          "2. Hình ảnh bài đăng không được chứa các hình ảnh đồi trụy"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Thực hiện tạo bài đăng đầu tiên",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.create_new_folder_sharp),
                children: [
                  ListTile(
                      title: Text("1. Chọn thể loại tin muốn tạo"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("2. Đăng ảnh mình họa cho tin"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("2. Hoàn thành biểu mẫu tạo tin đăng"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text("4. Nhấn nút tạo tin"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Duyệt bài",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.system_security_update_good_sharp),
                children: [
                  ListTile(
                      title: Text(
                          "1. Tin đăng vi phạm mục 'Tạo bài đăng' sẽ không được Admin duyệt bài"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                  ListTile(
                      title: Text(
                          "2. Sau khi được duyệt tin đăng sẽ hiển thị lên trang chủ của ChoTotHD"),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
