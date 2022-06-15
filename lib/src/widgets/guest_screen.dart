import 'package:chotot_app/src/pages/authentication/login/login_page.dart';
import 'package:flutter/material.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Vui lòng đăng nhập để sử dụng được nhiều tính năng bạn nha",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.orange.shade500),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  icon: Icon(
                    Icons.verified_user_outlined,
                    color: Colors.white,
                  ),
                  label: Text("Đăng nhập"))
            ],
          ),
        ),
      ),
    );
  }
}
