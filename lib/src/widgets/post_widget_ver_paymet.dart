import 'dart:async';
import 'dart:convert';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/pages/payment/payment_paypal_screen.dart';
import 'package:chotot_app/src/pages/payment/payment_vnpayy_screen.dart';
import 'package:chotot_app/src/repositories/payment_repo.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/base_widget.dart';
import 'package:chotot_app/src/widgets/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:chotot_app/src/common/base_convert.dart';

class PostWidgetpayment extends StatefulWidget {
  const PostWidgetpayment(
      {Key? key, required this.postData, required this.postShowingController})
      : super(key: key);
  final PostModel postData;
  // final Future? loadData;
  final StreamController<List<PostModel>> postShowingController;
  @override
  State<PostWidgetpayment> createState() => _PostWidgetpaymentState();
}

class _PostWidgetpaymentState extends State<PostWidgetpayment> {
  List<int> dateOfMonth = [31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  bool isAssignVNPay = true;
  loadData() async {
    try {
      var result = await PostServiceRepository()
          .getAllPostAuth(page: 0, limit: 10, status: 2);
      if (result.length == 0) {
        widget.postShowingController.add([]);
      } else {
        widget.postShowingController.sink.add(result);
      }
    } catch (err) {
      // widget.postShowingController.addError("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    int l = widget.postData.image.length;
    String img = widget.postData.image[l - 1];
    DateTime? dateStart = widget.postData.dateStartPost;
    // DateTime? dateEnd = widget.postData.dateEndPost;
    int monthStart = widget.postData.dateStartPost!.month;
    int dayStart = widget.postData.dateStartPost!.day;
    int timeActive = 0;
    var dateNow = DateTime.now();
    int date = dateNow.day - dateStart!.day;
    if (dateNow.month == monthStart) {
      if (date == 0) {
        timeActive = dateNow.hour - dateStart.hour;
      } else {
        timeActive = date;
      }
    } else {
      int day = dateNow.day;
      int d = dateOfMonth[dateNow.month - 1];
      date = d - dayStart + day;
      print(d.toString() + " " + dayStart.toString() + " " + day.toString());
    }
    return Container(
      //height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(30, 141, 145, 151),
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0)
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, right: 5),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                  height: 140,
                  width: 140,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
              Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black26),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  )),
              Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 28,
                  )),
            ]),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Marquee(
                    text: widget.postData.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    // scrollAxis: Axis.horizontal,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: Duration(seconds: 1),
                    showFadingOnlyWhenScrolling: true,
                    fadingEdgeStartFraction: 0.1,
                    fadingEdgeEndFraction: 0.1,
                    //numberOfRounds: 3,
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 8),
                  child: Row(
                    children: [
                      Text(
                        ("${widget.postData.prePrice}".toString()).toVND(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.orange.shade500,
                        size: 15,
                      ),
                      Text(
                        "- ${widget.postData.province}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.orange.shade500,
                        size: 15,
                      ),
                      date == 0
                          ? Text(
                              ' - $timeActive giờ trước',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.red),
                            )
                          : Text(
                              ' - $date ngày trước',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.red),
                            ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade500),
                          onPressed: () async {
                            var result = await PostServiceRepository()
                                .updateStatusPostAPI(
                                    idPost: widget.postData.id, status: 3);
                            if (result.statusCode == 200) {
                              showDialoga(
                                  title: "Thành công",
                                  subTitle: "Hủy bài đăng thành công",
                                  status: "Success");

                              loadData();
                            } else {
                              showDialoga(
                                  title: "Thất bại",
                                  subTitle: "Hủy bài đăng thất bại",
                                  status: "Fail");
                            }
                          },
                          child: Text("Hủy tin")),
                    ),
                    widget.postData.isAdvertised == true
                        ? Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: Text(
                              "Tin ưu tiên",
                              style: TextStyle(
                                  color: Colors.green.shade500, fontSize: 16),
                            ))
                        : Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange.shade500),
                                onPressed: () {
                                  print("Ưu tiên");
                                  Get.defaultDialog(
                                      title: "Thanh Toán",
                                      titleStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      backgroundColor: Colors.white,
                                      // middleText: "Chọn phương thức thanh toán",
                                      content: StatefulBuilder(
                                          builder: (context, setState) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isAssignVNPay = true;
                                                    });
                                                  },
                                                  child: Row(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5, right: 5),
                                                      child: Icon(
                                                        isAssignVNPay
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off,
                                                        color: isAssignVNPay
                                                            ? Colors.green
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 6),
                                                      child: Text(
                                                        "VNPay",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "OpenSans",
                                                            color: Colors.black,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 14),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ]),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isAssignVNPay = false;
                                                    });
                                                  },
                                                  child: Row(children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              right: 5),
                                                      child: Icon(
                                                        isAssignVNPay == false
                                                            ? Icons
                                                                .radio_button_checked
                                                            : Icons
                                                                .radio_button_off,
                                                        color: isAssignVNPay ==
                                                                false
                                                            ? Colors.green
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 11),
                                                      child: Text("Paypal",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "OpenSans",
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 14)),
                                                    ),
                                                  ]),
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                      middleTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textConfirm: "OK",
                                      textCancel: "Hủy",
                                      cancelTextColor: Colors.orange.shade500,
                                      confirmTextColor: Colors.white,
                                      onConfirm: () async {
                                        if (isAssignVNPay == true) {
                                          // print("Thanh toán VNPay");
                                          showDialogLoading(context);
                                          var result = await PaymentRepository()
                                              .preorityPostAPI(
                                                  idPost: widget.postData.id,
                                                  prices: 50000,
                                                  nameOfPoster: "Author");
                                          Navigator.pop(context);
                                          if (result.statusCode == 200 ||
                                              result.statusCode == 201) {
                                            String dataURL = "a";
                                            dataURL =
                                                jsonDecode(result.body)['data'];
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentVNPayScreen(
                                                          url: dataURL,
                                                          postID: widget
                                                              .postData.id,
                                                        )));
                                          } else {
                                            Get.snackbar(
                                              "Thất bại",
                                              "Thanh toán thất bại",
                                              duration: Duration(seconds: 3),
                                              margin: EdgeInsets.all(6),
                                              backgroundColor: Colors.white,
                                              leftBarIndicatorColor: Colors.red,
                                              colorText: Colors.black,
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                        } else {
                                          //print("Thanh toán paypal");
                                          showDialogLoading(context);
                                          var result = await PaymentRepository()
                                              .paymentPostAPI(
                                                  idPost: widget.postData.id,
                                                  price: 50000);
                                          Navigator.pop(context);
                                          if (result.statusCode == 200 ||
                                              result.statusCode == 201) {
                                            String dataURL = "a";
                                            dataURL =
                                                jsonDecode(result.body)['data'];
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentPaypalScreen(
                                                          url: dataURL,
                                                        )));
                                          } else {
                                            Get.snackbar(
                                              "Thất bại",
                                              "Thanh toán thất bại",
                                              duration: Duration(seconds: 3),
                                              margin: EdgeInsets.all(6),
                                              backgroundColor: Colors.white,
                                              leftBarIndicatorColor: Colors.red,
                                              colorText: Colors.black,
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          }
                                        }
                                      },
                                      onCancel: () {
                                        Navigator.of(context).pop();
                                      });
                                },
                                child: Text("Ưu tiên")),
                          )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
