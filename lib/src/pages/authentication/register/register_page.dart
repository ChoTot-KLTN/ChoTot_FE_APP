import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/models/district_model.dart';
import 'package:chotot_app/src/models/province.dart';
import 'package:chotot_app/src/models/village_model.dart';
import 'package:chotot_app/src/pages/authentication/login/login_page.dart';
import 'package:chotot_app/src/pages/authentication/verify/otp_verifycation_page.dart';
import 'package:chotot_app/src/repositories/authentication_repo.dart';

import 'package:chotot_app/src/repositories/location_repo.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';
import 'package:chotot_app/src/widgets/header_widget.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String province = "";
  String district = "";
  String village = "";

  String idProvince = "";
  String idDistrict = "";
  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController addressDetail = TextEditingController();
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child: HeaderWidget(250, true, Icons.account_box_outlined),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Đăng ký tài khoản",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ]),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mời nhập tên";
                            }
                            if (!RegExp('^[a-zA-Z]').hasMatch(value)) {
                              return 'Họ tên sai định dạng, nhập lại';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              "Họ tên", "Nhập họ tên", Icons.people),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phone,
                          validator: (value) {
                            if ((value!.isEmpty) &&
                                !RegExp(r"^(\d+)*$").hasMatch(value)) {
                              return "Số điện thoại không đúng";
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              "Điện thoại", "Nhập số điện thoại", Icons.phone),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            bool _isvalid = EmailValidator.validate(value!);
                            if (!_isvalid) {
                              return "Email không hợp lệ";
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              "Email", "Nhập Email", Icons.email),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: password,
                          decoration: InputDecoration(
                            labelText: "Mật khẩu",
                            hintText: "Nhập mật khẩu",
                            filled: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.orange.shade500,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0)),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Vui lòng nhập mật khẩu";
                            }
                            if ((!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                .hasMatch(val))) {
                              return "Mật khẩu sai định dạng";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: ThemeHelper().textInputDecoration(
                              'Địa chỉ', 'Nhập địa chỉ', Icons.location_city),
                          controller: addressDetail,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownSearch<Province>(
                          showSelectedItems: true,
                          compareFn: (i, s) => i?.isEqual(s!) ?? false,
                          dropdownSearchDecoration: ThemeHelper()
                              .textInputDecorationDrop("Chọn tỉnh thành"),
                          onFind: (string) =>
                              LocationRepository().getDataProvince(),
                          onChanged: (data) {
                            setState(() {
                              idProvince = data!.code;
                              province = data.name_with_type;
                              print(province + idProvince);
                              isSelectedProvince = true;
                            });
                          },
                          showSearchBox: true,
                          validator: (data) {
                            if (data == null) {
                              return "Chọn tỉnh thành";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownSearch<DistrictModel>(
                          showSelectedItems: true,
                          compareFn: (i, s) => i?.isEqual(s!) ?? false,
                          enabled: isSelectedProvince ? true : false,
                          dropdownSearchDecoration: ThemeHelper()
                              .textInputDecorationDrop("Chọn quận/thành phố"),
                          onFind: (string) =>
                              LocationRepository().getDataDicstrict(idProvince),
                          onChanged: (data) {
                            setState(() {
                              idDistrict = data!.code;
                              district = data.nameWithType;
                              print(district + idDistrict);
                              isSelectedDistrict = true;
                            });
                          },
                          showSearchBox: true,
                          validator: (data) {
                            if (data == null) {
                              return "Chọn quận/thành phố";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownSearch<Village>(
                          showSelectedItems: true,
                          compareFn: (i, s) => i?.isEqual(s!) ?? false,
                          enabled: isSelectedDistrict ? true : false,
                          dropdownSearchDecoration: ThemeHelper()
                              .textInputDecorationDrop("Chọn xã/phường"),
                          onFind: (string) =>
                              LocationRepository().getDataVillage(idDistrict),
                          onChanged: (data) {
                            setState(() {
                              village = data!.nameWithType;
                              print(village);
                            });
                          },
                          showSearchBox: true,
                          validator: (data) {
                            if (data == null) {
                              return "Chọn xã/phường";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Text("Đã có tài khoản đăng nhập ngay"),
                              onTap: () {
                                Get.to(() => LoginScreen());
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              showDialogLoading(context);
                              var status = await AuthenticationRepository()
                                  .registerAPI(
                                      name: name.text,
                                      email: email.text,
                                      phone: phone.text,
                                      addressDetail: addressDetail.text,
                                      province: province,
                                      district: district,
                                      village: village,
                                      password: password.text);
                              Get.back();
                              if (status.statusCode == 200) {
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
                              } else if (status.statusCode == 409 ||
                                  status.statusCode == 400) {
                                snackBar("Email hoặc số điện thoại đã tồn tại");
                              }
                            }
                          },
                          child: Text(
                            "Đăng ký ngay",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange.shade500,
                            fixedSize: Size(160, 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
