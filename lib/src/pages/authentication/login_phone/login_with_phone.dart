import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/pages/authentication/login_phone/login_otp.dart';

import 'package:chotot_app/src/pages/authentication/register/register_page.dart';
import 'package:chotot_app/src/repositories/authentication_repo.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Vui lòng nhập số điện thoại",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phone,
                  decoration: ThemeHelper().textInputDecoration(
                      "SĐT", "Nhập SĐT", Icons.phone_android_rounded),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng nhập SĐT";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade500),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialogLoading(context);
                        var result = await AuthenticationRepository()
                            .loginPhoneAPI(phone: phone.text);
                        Navigator.of(context).pop();
                        if (result.statusCode == 200) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  LoginPhoneOTPScreen(phone.text)));
                          print("send SMS");
                        } else {
                          Get.defaultDialog(
                              title: "Thất bại",
                              titleStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              backgroundColor: Colors.white,
                              middleText:
                                  "Số điện thoại chưa được đăng ký\nĐăng ký ngay",
                              middleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textConfirm: "OK",
                              textCancel: "Hủy",
                              cancelTextColor: Colors.black38,
                              onConfirm: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                              },
                              onCancel: () {});
                        }
                      }
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
      ),
    );
  }
}
