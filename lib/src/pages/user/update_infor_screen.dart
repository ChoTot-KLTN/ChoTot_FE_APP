import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/models/address_model.dart';
import 'package:chotot_app/src/models/district_model.dart';
import 'package:chotot_app/src/models/province.dart';
import 'package:chotot_app/src/models/user_model.dart';
import 'package:chotot_app/src/models/village_model.dart';
import 'package:chotot_app/src/pages/user/user_infor_screen.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:chotot_app/src/repositories/authentication_repo.dart';

import 'package:chotot_app/src/repositories/location_repo.dart';
import 'package:chotot_app/src/repositories/user_repo.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';

import 'package:chotot_app/src/widgets/header_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class UpdateInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateInfoScreenState();
  }
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController addressDetail = new TextEditingController();
  String province = "null";
  String district = "null";
  String village = "null";

  String idProvince = "";
  String idDistrict = "";

  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;

  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = userProvider.getUser!;
    name.text = user.name;
    addressDetail.text = user.address.detail;
    phone.text = user.phone;
  }

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.security_update_good),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                  height: 100,
                                  width: 100,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 0.5,
                                        color: Colors.orange.shade400),
                                    color: Colors.white,
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: Colors.black26,
                                    //       blurRadius: 20,
                                    //       offset: const Offset(5, 5))
                                    // ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade800,
                                    backgroundImage:
                                        AssetImage('assets/images/avatar.png'),
                                  )),
                              Positioned(
                                  height: 150,
                                  width: 140,
                                  child: IconButton(
                                    onPressed: () {
                                      print("pick ảnh");
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      size: 28,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Fullname', 'Enter your Fullname'),
                            controller: name,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter fullname';
                              }
                              if (!RegExp('^[a-zA-Z]').hasMatch(val)) {
                                return 'Invalid fullname';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Address', 'Enter your Address'),
                            controller: addressDetail,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
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
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Mobile Number", "Enter your mobile number"),
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if ((val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: 45,
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Update".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  showDialogLoading(context);
                                  var status = await AuthenticationRepository()
                                      .updateInfoAPI(
                                          name: name.text,
                                          phone: phone.text,
                                          address: AddressModel(
                                              detail: addressDetail.text,
                                              village: village,
                                              district: district,
                                              province: province));

                                  Navigator.pop(context);

                                  if (status.statusCode == 200) {
                                    await AuthenticationRepository()
                                        .getAuthAPI()
                                        .then((user) {
                                      if (user != null) {
                                        userProvider.setUser = user;
                                      }
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreen()),
                                        (route) => false);
                                  } else if (status.statusCode == 404) {
                                    snackBar("Không tìm thầy user");
                                  } else {
                                    snackBar("Lỗi API");
                                  }
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
