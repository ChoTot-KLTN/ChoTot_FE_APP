import 'package:chotot_app/src/common/common_const.dart';
import 'package:flutter/material.dart';
import 'package:chotot_app/src/common/base_convert.dart';

class FilterScreen extends StatelessWidget {
  final String typePost;
  final Function callBackFunc;
  const FilterScreen(
      {Key? key, required this.callBackFunc, required this.typePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String brand = listBrandCar[0];
    List<String> listSelected = [];
    if (typePost == "Car") {
      brand = listBrandCar[0];
      listSelected = listBrandCar;
    } else if (typePost == "Motorbike") {
      brand = listBrandMotorbike[0];
      listSelected = listBrandMotorbike;
    } else if (typePost == 'Bicycle') {
      brand = listBrandBicycle[0];
      listSelected = listBrandBicycle;
    } else if (typePost == 'Phone') {
      brand = listBrandPhone[0];
      listSelected = listBrandPhone;
    } else if (typePost == "Laptop") {
      brand = listBrandLaptop[0];
      listSelected = listBrandLaptop;
    }
    int startPrice = 0;
    int endPrice = 10000000;
    RangeValues values = RangeValues(100000, 1500000000);
    Size size = MediaQuery.of(context).size;
    RangeLabels labels = RangeLabels(
        values.start.round().toString(), values.end.round().toString());

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: 60, bottom: 20, left: 10, right: 10),
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Điều kiện lọc",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Giá: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                "${values.start.round().toString().toVND()} - ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                "${values.end.round().toString().toVND()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RangeSlider(
                              values: values,
                              labels: labels,
                              divisions: 30,
                              min: 100000,
                              max: 1500000000,
                              onChanged: (newValues) {
                                setState(() {
                                  values = newValues;
                                  startPrice = values.start.toInt();
                                  endPrice = values.end.toInt();
                                });
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text(
                                "Hãng",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: DropdownButton(
                                  menuMaxHeight: size.width,
                                  underline: SizedBox(),
                                  isExpanded: false,
                                  value: brand,
                                  onChanged: (value) {
                                    setState(() {
                                      brand = value.toString();
                                    });
                                  },
                                  items: listSelected.map((e) {
                                    return DropdownMenuItem(
                                      child: new Text(e),
                                      value: e,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange.shade500,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 40)),
                              onPressed: () {
                                print(brand);
                                print(startPrice.toString());
                                print(endPrice.toString());
                                // Navigator.of(context).popAndPushNamed(
                                //   'carScreen',
                                // );
                                Navigator.of(context).pop();
                                callBackFunc(brand, endPrice, startPrice);
                              },
                              child: Text(
                                "Áp dụng",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
                });
          },
          child: Container(
            width: 80,
            height: 40,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list_alt),
                Text(
                  "Lọc",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
