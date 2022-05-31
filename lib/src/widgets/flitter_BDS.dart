import 'package:chotot_app/src/common/common_const.dart';
import 'package:flutter/material.dart';
import 'package:chotot_app/src/common/base_convert.dart';

class FilterBDSScreen extends StatelessWidget {
  final String typePost;
  final Function callBackFunc;
  const FilterBDSScreen(
      {Key? key, required this.callBackFunc, required this.typePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int startPrice = 0;
    int endPrice = 10000000;
    RangeValues values = RangeValues(100000, 1500000000);
    Size size = MediaQuery.of(context).size;
    RangeLabels labels = RangeLabels(
        values.start.round().toString(), values.end.round().toString());

    double startArea = 0.0;
    double endArea = 10000.0;

    RangeValues valueArea = RangeValues(10, 10000);

    RangeLabels labelArea =
        RangeLabels(valueArea.start.toString(), valueArea.end.toString());

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
                              Text(
                                "Diện tích: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                "${valueArea.start.round().toString()} - ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                              Text(
                                "${valueArea.end.round().toString()} m2",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RangeSlider(
                              values: valueArea,
                              labels: labelArea,
                              divisions: 50,
                              min: 0,
                              max: 10000,
                              onChanged: (newValues) {
                                setState(() {
                                  valueArea = newValues;
                                  startArea = valueArea.start;
                                  endArea = valueArea.end;
                                });
                              }),
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
                                Navigator.of(context).pop();
                                callBackFunc(
                                    endPrice, startPrice, endArea, startArea);
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
