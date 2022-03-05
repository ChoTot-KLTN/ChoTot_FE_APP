import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/pages/authentication/forgot_password/forgot_pass_otp.dart';
import 'package:chotot_app/src/repositories/authentication_repo.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: email,
                decoration: ThemeHelper()
                    .textInputDecoration("Email", "Nhập Email", Icons.email),
                validator: (value) {
                  bool _isvalid = EmailValidator.validate(value!);
                  if (!_isvalid) {
                    return "Email không hợp lệ";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialogLoading(context);
                    var status = await AuthenticationRepository()
                        .forgotPasswordAPI(email: email.text);
                    Get.back();
                    if (status.statusCode == 200) {
                      Get.defaultDialog(
                          title: "Xác thực mã otp",
                          titleStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          backgroundColor: Colors.orange.shade300,
                          middleText: "Nhận mã otp tại Email hoặc Phone",
                          middleTextStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          textConfirm: "OK",
                          onConfirm: () {
                            Get.to(() => PinCodeScreen(
                                  emailCurrent: email.text,
                                ));
                          });
                    } else {
                      Get.snackbar(
                        "Lấy lại mật khẩu thất bại",
                        "Email không tồn tại",
                        duration: Duration(seconds: 4),
                        margin: EdgeInsets.all(6),
                        backgroundColor: Color(0x80000000),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.seedling,
                  color: Colors.white,
                ),
                label: Text(
                  "Gửi",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade500,
                  fixedSize: Size(120, 42),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
