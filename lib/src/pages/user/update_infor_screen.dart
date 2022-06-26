import 'dart:io';

import 'package:chotot_app/src/services/storage_service.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

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

import 'package:image_cropper/image_cropper.dart';

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
  XFile? pickImage;
  File? imageCrop;
  // final cropKey = GlobalKey<CropState>();
  late DistrictModel defaultDistrict;
  late Province defaultProvince;
  late Village defaultVillage;
  @override
  void initState() {
    super.initState();
    user = userProvider.getUser!;
    name.text = user.name;
    addressDetail.text = user.address.detail;
    phone.text = user.phone;
    defaultDistrict =
        DistrictModel(code: "1", nameWithType: user.address.district);
    defaultProvince = Province(
        name: user.address.province,
        name_with_type: user.address.province,
        type: "1",
        code: "1");
    defaultVillage = Village(code: "1", nameWithType: user.address.village);
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  showPickOptionDialog(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      context: context,
      builder: (context) => Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(Icons.photo_album),
                title: Text("Chọn ảnh có sẵn"),
                onTap: () {
                  loadPicker(ImageSource.gallery);
                  print("có sẵn");
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Expanded(
              child: ListTile(
                leading: Icon(Icons.camera),
                title: Text("Chọn ảnh từ camera"),
                onTap: () {
                  loadPicker(ImageSource.camera);
                  print("camera");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  cropImagefunc(XFile picked) async {
    File? cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        maxHeight: MediaQuery.of(context).size.height.toInt(),
        maxWidth: MediaQuery.of(context).size.width.toInt(),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            backgroundColor: Colors.white,
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (cropped != null) {
      setState(() {
        pickImage = XFile(cropped.path);
      });
    }
  }

  loadPicker(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final picked = await _picker.pickImage(source: source);
    if (picked != null) {
      cropImagefunc(picked);
      setState(() {
        pickImage = picked;
        // print('Pick path;' + pickImage!.path);
      });
    }
    Navigator.of(context).pop();
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
                                    backgroundImage: pickImage == null
                                        ? AssetImage('assets/images/avatar.png')
                                        : FileImage(File(pickImage!.path))
                                            as ImageProvider,
                                  )),
                              Positioned(
                                  height: 150,
                                  width: 140,
                                  child: IconButton(
                                    onPressed: () {
                                      showPickOptionDialog(context);
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
                          // selectedItem: defaultProvince,
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
                          // selectedItem: defaultDistrict,
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
                          // selectedItem: defaultVillage,
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
                                    var file = await StorageService()
                                        .uploadFileToStorage(pickImage!.path);
                                    print("object: " + file.toString());
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
