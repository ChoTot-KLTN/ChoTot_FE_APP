import 'dart:convert';

import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/pages/authentication/forgot_password/forgot_password_page.dart';
import 'package:chotot_app/src/pages/authentication/register/register_page.dart';
import 'package:chotot_app/src/pages/authentication/verify/otp_verifycation_page.dart';
import 'package:chotot_app/src/pages/home/home_nav_page.dart';
import 'package:chotot_app/src/repositories/authentication_repo.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';
import 'package:chotot_app/src/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;
  var _headerHeight = 250.0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            SafeArea(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "Welcome to ChoTotHD",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Please! login first",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email,
                            decoration: ThemeHelper().textInputDecoration(
                                "Email", "Nhập Email", Icons.email),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Vui lòng nhập Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              hintText: "Nhập mật khẩu",
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.orange.shade500,
                              ),
                              suffixIcon: IconButton(
                                icon: _obscure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscure = !_obscure;
                                  });
                                },
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Vui lòng nhập mật khẩu";
                              }
                              return null;
                            },
                            obscureText: _obscure,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Bạn chưa có tài khoàn?"),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                child: Text("Đăng ký ngay"),
                                onTap: () {
                                  Get.to(() => RegisterScreen());
                                  print("Đăng ký ngay");
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Text("Quên mật khẩu"),
                                onTap: () {
                                  print("quên mật khẩu");
                                  Get.to(() => ForgotPasswordScreen());
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                // fixedSize: Size(120, 40),
                                primary: Colors.orange.shade500),
                            onPressed: () async {
                              print(email.text + password.text);
                              if (_formKey.currentState!.validate()) {
                                showDialogLoading(context);
                                var status = await AuthenticationRepository()
                                    .loginAPI(
                                        email: email.text,
                                        password: password.text);
                                print(status.statusCode);
                                Get.back();
                                if (status.statusCode == 200) {
                                  var dataResponse = jsonDecode(status.body);
                                  await GetStorage().write('token',
                                      dataResponse['data']['accessToken']);

                                  Get.to(() => MyHomePage());
                                } else if (status.statusCode == 401) {
                                  Get.defaultDialog(
                                      title: "Xác thực tài khoản",
                                      titleStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      backgroundColor: Colors.orange.shade300,
                                      middleText:
                                          "Nhận mã otp tại Email hoặc Phone",
                                      middleTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textConfirm: "OK",
                                      onConfirm: () {
                                        Get.to(() => PinCodeVerificationScreen(
                                            email.text));
                                      });
                                } else {
                                  snackBar("Sai tài khoản hoặc mật khẩu");
                                }
                              }
                            },
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Hoặc đăng nhập bằng"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print("login with facebook");
                                },
                                icon: FaIcon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              IconButton(
                                onPressed: () {
                                  print("login with email");
                                },
                                icon: FaIcon(
                                  Icons.email,
                                  color: Colors.red.shade800,
                                  size: 35,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              IconButton(
                                onPressed: () {
                                  print("Login with Google");
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.googlePlus,
                                  color: Colors.red.shade700,
                                  size: 33,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
