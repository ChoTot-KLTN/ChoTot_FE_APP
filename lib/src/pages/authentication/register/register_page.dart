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
                                "????ng k?? t??i kho???n",
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
                              return "M???i nh???p t??n";
                            }
                            if (!RegExp('^[a-zA-Z]').hasMatch(value)) {
                              return 'H??? t??n sai ?????nh d???ng, nh???p l???i';
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              "H??? t??n", "Nh???p h??? t??n", Icons.people),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phone,
                          validator: (value) {
                            if ((value!.isEmpty) &&
                                !RegExp(r"^(\d+)*$").hasMatch(value)) {
                              return "S??? ??i???n tho???i kh??ng ????ng";
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              "??i???n tho???i", "Nh???p s??? ??i???n tho???i", Icons.phone),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            bool _isvalid = EmailValidator.validate(value!);
                            if (!_isvalid) {
                              return "Email kh??ng h???p l???";
                            }
                            return null;
                          },
                          decoration: ThemeHelper().textInputDecoration(
                              "Email", "Nh???p Email", Icons.email),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: password,
                          decoration: InputDecoration(
                            labelText: "M???t kh???u",
                            hintText: "Nh???p m???t kh???u",
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
                              return "Vui l??ng nh???p m???t kh???u";
                            }
                            if ((!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                .hasMatch(val))) {
                              return "M???t kh???u sai ?????nh d???ng";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: ThemeHelper().textInputDecoration(
                              '?????a ch???', 'Nh???p ?????a ch???', Icons.location_city),
                          controller: addressDetail,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownSearch<Province>(
                          showSelectedItems: true,
                          compareFn: (i, s) => i?.isEqual(s!) ?? false,
                          dropdownSearchDecoration: ThemeHelper()
                              .textInputDecorationDrop("Ch???n t???nh th??nh"),
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
                              return "Ch???n t???nh th??nh";
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
                              .textInputDecorationDrop("Ch???n qu???n/th??nh ph???"),
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
                              return "Ch???n qu???n/th??nh ph???";
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
                              .textInputDecorationDrop("Ch???n x??/ph?????ng"),
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
                              return "Ch???n x??/ph?????ng";
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
                              child: Text("???? c?? t??i kho???n ????ng nh???p ngay"),
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
                                    title: "X??c th???c t??i kho???n",
                                    titleStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    backgroundColor: Colors.orange.shade300,
                                    middleText:
                                        "Nh???n m?? otp t???i Email ho???c Phone",
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
                                snackBar("Email ho???c s??? ??i???n tho???i ???? t???n t???i");
                              }
                            }
                          },
                          child: Text(
                            "????ng k?? ngay",
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
