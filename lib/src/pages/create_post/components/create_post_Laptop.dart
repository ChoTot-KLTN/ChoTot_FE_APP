import 'package:chotot_app/src/common/common_const.dart';
import 'package:chotot_app/src/common/theme_helper.dart';
import 'package:chotot_app/src/models/district_model.dart';
import 'package:chotot_app/src/models/province.dart';
import 'package:chotot_app/src/models/village_model.dart';
import 'package:chotot_app/src/repositories/location_repo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostLaptopScreen extends StatefulWidget {
  const CreatePostLaptopScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostLaptopScreen> createState() => _CreatePostLaptopScreenState();
}

class _CreatePostLaptopScreenState extends State<CreatePostLaptopScreen> {
  bool isUse = false;
  bool isNew = false;

  TextEditingController addressDetail = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController titlePoster = TextEditingController();
  TextEditingController descriptionPoster = TextEditingController();
  String province = "";
  String district = "";
  String village = "";

  String idProvince = "";
  String idDistrict = "";
  String brandLaptop = listBrandLaptop[0];
  String microprocessor = listMicroprocessorLaptop[0];
  String ram = listRAM[0];
  String hardDrive = listHardDrive[0];
  String typeHardDrive = listTypeHardDrive[0];
  String card = listGraphicsCard[0];
  String guarantee = listGuarantee[0];
  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;

  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  final _formkey2 = GlobalKey<FormState>();
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
                        'Đồ điện tử - Laptop',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),

                //buildTitle("ĐỊA CHỈ BĐS VÀ HÌNH ẢNH", size),

                SizedBox(
                  height: 20,
                ),
                buildTitle("THÔNG TIN CHI TIẾT", size),
                Padding(
                    padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                    child: buildSelectedImage(size)),
                Padding(
                  padding: EdgeInsets.only(right: 15, left: 15, top: 10),
                  child: Form(
                    key: _formkey,
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
                              Text("Hãng: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: brandLaptop,
                                  onChanged: (value) {
                                    setState(() {
                                      brandLaptop = value.toString();
                                    });
                                  },
                                  items: listBrandLaptop.map((e) {
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
                              Text("Vi xử lý: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: microprocessor,
                                  onChanged: (value) {
                                    setState(() {
                                      microprocessor = value.toString();
                                    });
                                  },
                                  items: listMicroprocessorLaptop.map((e) {
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
                              Text("RAM: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: ram,
                                  onChanged: (value) {
                                    setState(() {
                                      ram = value.toString();
                                    });
                                  },
                                  items: listRAM.map((e) {
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
                              Text("Ổ cứng: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: hardDrive,
                                  onChanged: (value) {
                                    setState(() {
                                      hardDrive = value.toString();
                                    });
                                  },
                                  items: listHardDrive.map((e) {
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
                              Text("Loại ổ cứng: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: typeHardDrive,
                                  onChanged: (value) {
                                    setState(() {
                                      typeHardDrive = value.toString();
                                    });
                                  },
                                  items: listTypeHardDrive.map((e) {
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
                              Text("Card màn hình: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: card,
                                  onChanged: (value) {
                                    setState(() {
                                      card = value.toString();
                                    });
                                  },
                                  items: listGraphicsCard.map((e) {
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
                        Text(
                          'Tình trạng',
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
                                print("Đã sử dụng");
                                setState(() {
                                  isUse = true;
                                  isNew = false;
                                });
                              },
                              child: Text(
                                'Đã sử dụng',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 4,
                                          bottom: 4)),
                                  backgroundColor: isUse
                                      ? MaterialStateProperty.all(
                                          Colors.orange.shade200)
                                      : MaterialStateProperty.all(
                                          Colors.grey.shade300),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(120, 35))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                print("Mới");
                                setState(() {
                                  isUse = false;
                                  isNew = true;
                                });
                              },
                              child: Text(
                                'Mới',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          top: 4,
                                          bottom: 4)),
                                  backgroundColor: isNew
                                      ? MaterialStateProperty.all(
                                          Colors.orange.shade200)
                                      : MaterialStateProperty.all(
                                          Colors.grey.shade300),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(70, 35))),
                            ),
                          ],
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
                              Text("Bảo hành: "),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  underline: SizedBox(),
                                  menuMaxHeight: size.width,
                                  isExpanded: true,
                                  value: guarantee,
                                  onChanged: (value) {
                                    setState(() {
                                      guarantee = value.toString();
                                    });
                                  },
                                  items: listGuarantee.map((e) {
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
                        TextFormField(
                          controller: price,
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

                buildTitle("TIÊU ĐỀ VÀ MÔ TẢ", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Form(
                    key: _formkey1,
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
                buildTitle("VỀ NGƯỜI BÁN", size),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Form(
                      key: _formkey2,
                      child: Column(
                        children: [
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
                        ],
                      )),
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

  Widget buildSelectedImage(Size size) {
    return GestureDetector(
      onTap: () {
        print('chụp ảnh');
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
            onPressed: () {
              if (_formkey.currentState!.validate() ||
                  _formkey1.currentState!.validate() ||
                  _formkey2.currentState!.validate()) {}
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
