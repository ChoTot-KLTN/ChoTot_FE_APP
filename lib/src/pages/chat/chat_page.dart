import 'package:chotot_app/src/pages/authentication/login/login_page.dart';
import 'package:chotot_app/src/pages/home/home_nav_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var token = GetStorage().read("token");
  // UserModel? currentUser;
  @override
  void initState() {
    // AuthenticationRepository().getAuthAPI().then((user) {
    //   if (user != null) {
    //     userProvider.setUser = user;
    //     setState(() {});
    //   }
    // });
    // currentUser = userProvider.getUser;
    //setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Text(token),
          ElevatedButton(
              onPressed: () {
                GetStorage().remove('token');
                Get.to(() => LoginScreen());
              },
              child: Text("Thoát")),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => MyHomePage());
              },
              child: Text("home"))
        ]),
      ),
    );
  }
}
