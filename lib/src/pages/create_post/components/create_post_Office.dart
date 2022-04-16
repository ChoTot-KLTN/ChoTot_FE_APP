import 'dart:io';

import 'package:chotot_app/src/common/common_const.dart';
import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/models/address_model.dart';
import 'package:chotot_app/src/models/district_model.dart';
import 'package:chotot_app/src/models/province.dart';
import 'package:chotot_app/src/models/village_model.dart';
import 'package:chotot_app/src/repositories/location_repo.dart';
import 'package:chotot_app/src/repositories/post_repo.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostOfficeScreen extends StatefulWidget {
  const CreatePostOfficeScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostOfficeScreen> createState() => _CreatePostOfficeScreenState();
}

class _CreatePostOfficeScreenState extends State<CreatePostOfficeScreen> {
  bool isSafe = false; // bán
  bool isBorrow = false; // thuê
  TextEditingController building = TextEditingController(); // tên tòa nhà
  TextEditingController addressDetail = TextEditingController();
  TextEditingController codeBuilding = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController floor = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController titlePoster = TextEditingController();
  TextEditingController descriptionPoster = TextEditingController();
  String province = "";
  String district = "";
  String village = "";

  String idProvince = "";
  String idDistrict = "";
  String typeOffice = "Mặt bằng kinh doanh";
  String numRoom = numberOfRoom[0];
  String numBadRoom = numberOfRoom[0];
  String directionBalcony = direction[0];
  String directionDoor = direction[0];
  String juridical = listJuridical[0]; // pháp lý
  String apartmentStatus = listApartmentStatus[0]; // tình trạng nội thất
  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;
  List<String> listTypeOffice = [
    'Mặt bằng kinh doanh',
    'Văn phòng',
    'Shophouse',
    'Officetel'
  ];
  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  List<XFile> _selectedFile = [];
  List<String> arrImageURl = [];
  FirebaseStorage? _storageRef = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Đăng tin',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.cancel_outlined))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bất động sản - Văn phòng, Mặt bằng',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Danh mục bất động sản',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              print("bán");
                              setState(() {
                                isSafe = true;
                                isBorrow = false;
                              });
                            },
                            child: Text(
                              'Cần bán',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        left: 5, right: 5, top: 4, bottom: 4)),
                                backgroundColor: isSafe
                                    ? MaterialStateProperty.all(
                                        Colors.orange.shade200)
                                    : MaterialStateProperty.all(
                                        Colors.grey.shade300),
                                fixedSize:
                                    MaterialStateProperty.all(Size(70, 35))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              print("cho thuê");
                              setState(() {
                                isSafe = false;
                                isBorrow = true;
                              });
                            },
                            child: Text(
                              'Cho thuê',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        left: 5, right: 5, top: 4, bottom: 4)),
                                backgroundColor: isBorrow
                                    ? MaterialStateProperty.all(
                                        Colors.orange.shade200)
                                    : MaterialStateProperty.all(
                                        Colors.grey.shade300),
                                fixedSize:
                                    MaterialStateProperty.all(Size(70, 35))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTitle("ĐỊA CHỈ BĐS VÀ HÌNH ẢNH", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: building,
                            decoration: ThemeHelper()
                                .textInputDecorationWithOutBorderRadius(
                                    "Tên tòa nhà, khu dân cư",
                                    "Tên tòa nhà / khu dân cư / dự án"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nhập tên tòa nhà";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecorationWithOutBorderRadius(
                                    "Địa chỉ", "Địa chỉ"),
                            controller: addressDetail,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nhập tên đường";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownSearch<Province>(
                            showSelectedItems: true,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDropWithOutBorderRadius(
                                    "Chọn tỉnh thành"),
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
                                .textInputDecorationDropWithOutBorderRadius(
                                    "Chọn quận/thành phố"),
                            onFind: (string) => LocationRepository()
                                .getDataDicstrict(idProvince),
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
                                .textInputDecorationDropWithOutBorderRadius(
                                    "Chọn xã/phường"),
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
                          buildSelectedImage(size),
                          Container(
                            padding:
                                EdgeInsets.only(right: 15, left: 15, top: 10),
                            child: _selectedFile.length == 0
                                ? Text("Chưa có ảnh nào")
                                : SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return buildImage(
                                            _selectedFile[index].path, index);
                                      },
                                      itemCount: _selectedFile.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: ScrollPhysics(),
                                    ),
                                  ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTitle("VÍ TRÍ BĐS", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: codeBuilding,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Mã căn", "Mã căn"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Vui lòng nhập mã căn";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: block,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Block/Tháp", "Block/Tháp"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Vui lòng nhập block/tháp";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: floor,
                          keyboardType: TextInputType.number,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Tầng số", "Tầng số"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Vui lòng nhập tầng";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTitle("THÔNG TIN CHI TIẾT", size),
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              Text("Loại hình văn phòng: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  menuMaxHeight: size.width,
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  value: typeOffice,
                                  onChanged: (value) {
                                    setState(() {
                                      typeOffice = value.toString();
                                    });
                                  },
                                  items: listTypeOffice.map((e) {
                                    return DropdownMenuItem(
                                      child: new Text(e),
                                      value: e,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              Text("Hướng cửa chính: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  menuMaxHeight: size.width,
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  value: directionDoor,
                                  onChanged: (value) {
                                    setState(() {
                                      directionDoor = value.toString();
                                    });
                                  },
                                  items: direction.map((e) {
                                    return DropdownMenuItem(
                                      child: new Text(e),
                                      value: e,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTitle("THÔNG TIN KHÁC", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            Text("Giấy tờ pháp lý: "),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 1,
                              child: DropdownButton(
                                menuMaxHeight: size.width,
                                underline: SizedBox(),
                                isExpanded: true,
                                value: juridical,
                                onChanged: (value) {
                                  setState(() {
                                    juridical = value.toString();
                                  });
                                },
                                items: listJuridical.map((e) {
                                  return DropdownMenuItem(
                                    child: new Text(e),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: [
                            Text("Nội thất: "),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 1,
                              child: DropdownButton(
                                menuMaxHeight: size.width,
                                underline: SizedBox(),
                                isExpanded: true,
                                value: apartmentStatus,
                                onChanged: (value) {
                                  setState(() {
                                    apartmentStatus = value.toString();
                                  });
                                },
                                items: listApartmentStatus.map((e) {
                                  return DropdownMenuItem(
                                    child: new Text(e),
                                    value: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTitle("DIỆN TÍCH & GIÁ", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Form(
                    key: _formkey1,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: area,
                          keyboardType: TextInputType.number,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Diện tích", "Diện tích (m2)"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Không được để trống diện tích";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: price,
                          keyboardType: TextInputType.number,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Giá", "Giá tiền"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Không được để trống giá";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildTitle("TIÊU ĐỀ TIN Đăng VÀ Mô TẢ CHI TIẾT", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Form(
                    key: _formkey2,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titlePoster,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Tiêu đề", "Tiêu đề tin đăng"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Tiêu đề không được bỏ trống";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          controller: descriptionPoster,
                          decoration: ThemeHelper()
                              .textInputDecorationDropWithOutBorderRadius(
                                  "Mô tả", "Mô tả chi tiết"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mô tả không được bỏ trống";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildFooter(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title, Size size) {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 20, bottom: 3),
      height: 50,
      width: size.width,
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
      ),
      decoration: BoxDecoration(color: Colors.grey.shade300),
    );
  }

  Widget buildImage(String path, int index) {
    return Container(
      child: Stack(children: [
        Container(
          height: 150,
          width: 150,
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: GestureDetector(
            onTap: () {
              print("Delete: " + index.toString());
              setState(() {
                _selectedFile.removeAt(index);
              });
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.white),
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black38),
              child: Center(
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        index == 0
            ? Positioned(
                bottom: 15,
                left: 20,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.black38),
                  child: Text(
                    'Hình bìa',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
            : SizedBox()
      ]),
    );
  }

  void uploadFunction(List<XFile> images) {
    for (int i = 0; i < _selectedFile.length; i++) {
      uploadFile(images[i]);
      // print("URL: " + imageURL);
      // arrImageURl.add(imageURL.toString());
    }
  }

  // function lưu file ảnh lên firebase
  Future<String> uploadFile(XFile image) async {
    Reference reference =
        _storageRef!.ref().child("multiple_images").child(image.name);
    UploadTask uploadTask = reference.putFile(File(image.path));
    // await uploadTask.whenComplete(() {
    //   print("ref URL: " + reference.getDownloadURL().toString());
    // });
    uploadTask.whenComplete(() async {
      try {
        String url = await reference.getDownloadURL();
        arrImageURl.add(url);
        // print("url in uploadFile: " + url);
      } catch (err) {
        print("lỗi " + err.toString());
      }
    });
    return await reference.getDownloadURL();
  }

  // function pick ảnh
  void selectedImage() async {
    if (_selectedFile != null) {
      _selectedFile.clear();
    }
    try {
      final List<XFile>? imgs = await _imagePicker.pickMultiImage();
      if (imgs!.isNotEmpty) {
        _selectedFile.addAll(imgs);
        setState(() {});
      }
    } on PlatformException catch (err) {
      print("flatform: " + err.toString());
    } catch (err) {
      print("sai roi: " + err.toString());
    }
    print("image length: " + _selectedFile.length.toString());
    setState(() {});
  }

  Widget buildSelectedImage(Size size) {
    return GestureDetector(
      onTap: () {
        print('chụp ảnh');
        selectedImage();
      },
      child: Container(
        width: size.width,
        height: 80,
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade300,
            border: Border.all(width: 0.5, color: Colors.orange.shade400)),
        child: Column(
          children: [
            Icon(
              Icons.camera_alt,
              size: 30,
            ),
            Text("Đăng tối đa 6 ảnh"),
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text("XEM TRƯỚC TIN",
                style: TextStyle(
                    color: Colors.orange.shade500,
                    fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(5),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: Colors.orange.shade500)),
                fixedSize: Size(150, 50)),
          ),
          SizedBox(
            width: 15,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formkey.currentState!.validate() &&
                  _formkey1.currentState!.validate() &&
                  _formkey2.currentState!.validate()) {
                showDialogLoading(context);
                if (_selectedFile.isNotEmpty) {
                  uploadFunction(_selectedFile);
                } else {
                  arrImageURl = ['1', '2', '3'];
                }
                await Future.delayed(Duration(seconds: 5), () {
                  print('upload succes');
                });
                AddressModel address = AddressModel(
                    detail: addressDetail.text,
                    village: village,
                    district: district,
                    province: province);
                String type = "sale";
                if (isSafe == true) {
                  type = "sale";
                } else {
                  type = "borrow";
                }
                PostOfficeModelRequired postOfficeModelRequired =
                    PostOfficeModelRequired(
                        nameOfBuilding: building.text,
                        address: address,
                        codeBuilding: codeBuilding.text,
                        block: block.text,
                        floor: int.parse(floor.text),
                        typeOffice: typeOffice,
                        doorDirection: directionDoor,
                        juridical: juridical,
                        interiorCondition: apartmentStatus,
                        area: double.parse(area.text),
                        price: int.parse(price.text));
                var result = await PostRepository().createPostOffice(
                    onModel: "PostOffice",
                    title: titlePoster.text,
                    content: descriptionPoster.text,
                    image: arrImageURl,
                    type: type,
                    postOfficeModel: postOfficeModelRequired);
                Get.back();
                if (result.statusCode == 200) {
                  arrImageURl.clear();
                  Get.snackbar(
                    "Thành công",
                    "Tạo bài đăng thành công",
                    duration: Duration(seconds: 3),
                    margin: EdgeInsets.all(6),
                    backgroundColor: Colors.white,
                    leftBarIndicatorColor: Colors.green,
                    colorText: Colors.green.shade500,
                    snackPosition: SnackPosition.TOP,
                  );
                } else {
                  Get.snackbar(
                    "Thất bại",
                    "Tạo bài đăng thất bại",
                    duration: Duration(seconds: 3),
                    margin: EdgeInsets.all(6),
                    backgroundColor: Colors.white,
                    leftBarIndicatorColor: Colors.red,
                    colorText: Colors.red.shade500,
                    snackPosition: SnackPosition.TOP,
                  );
                }
              }
            },
            child: Text("ĐĂNG TIN",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(5),
                primary: Colors.orange.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                fixedSize: Size(150, 50)),
          ),
        ],
      ),
    );
  }
}
