import 'package:chotot_app/src/pages/another/more_page.dart';
import 'package:chotot_app/src/pages/create_post/create_post_page.dart';
import 'package:chotot_app/src/pages/home/home_page.dart';
import 'package:chotot_app/src/pages/managePost/manage_post_screen.dart';
import 'package:chotot_app/src/pages/notification/notification_page.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:chotot_app/src/repositories/authentication_repo.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  Widget child = Text("CMM");
  Widget appbarWithpage = Text("hello");

  @override
  void initState() {
    // get infor user
    AuthenticationRepository().getAuthAPI().then((user) {
      if (user != null) {
        userProvider.setUser = user;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_index) {
      case 0:
        child = HomeScreen();
        break;
      case 1:
        child = ManagePostScreen();
        break;
      case 2:
        child = CreatePostScreen();
        break;
      case 3:
        child = NotificationScreen();
        break;
      default:
        child = MoreScreen();
        break;
    }
    return Scaffold(
      body: child,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Colors.orange.shade500,
        activeColor: Colors.red,
        items: [
          TabItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: "Trang chủ"),
          TabItem(
              icon: Icon(Icons.people, color: Colors.white),
              title: "Quản lý tin"),
          TabItem(
              icon: Icon(
                Icons.app_registration,
                color: Colors.white,
              ),
              title: "Đăng tin"),
          TabItem(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: "Thông tin"),
          TabItem(
              icon: Icon(
                Icons.contact_mail,
                color: Colors.white,
              ),
              title: "Thêm"),
        ],
        initialActiveIndex: 2,
        onTap: (int i) {
          print('click index = $i');
          setState(() {
            _index = i;
          });
        },
      ),
    );
  }
}
