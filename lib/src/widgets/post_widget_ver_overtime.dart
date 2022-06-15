import 'dart:async';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:chotot_app/src/common/base_convert.dart';

class PostwidgetOverTime extends StatefulWidget {
  const PostwidgetOverTime(
      {Key? key, required this.postData, required this.postOvertimeController})
      : super(key: key);
  final PostModel postData;
  // final Future loadData;
  final StreamController<List<PostModel>> postOvertimeController;
  @override
  State<PostwidgetOverTime> createState() => _PostwidgetOvertimeState();
}

class _PostwidgetOvertimeState extends State<PostwidgetOverTime> {
  List<int> dateOfMonth = [31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  loadData() async {
    try {
      var result = await PostServiceRepository()
          .getAllPostOvertime(page: 0, limit: 10, status: 2);
      if (result.length == 0) {
        widget.postOvertimeController.add([]);
      } else {
        widget.postOvertimeController.add(result);
      }
    } catch (err) {
      // widget.postOvertimeController.addError("error");
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
    }

    return Container(
      height: 150,
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
            padding: const EdgeInsets.only(top: 10, right: 5),
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
                    padding: const EdgeInsets.all(5),
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
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 8),
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
                  padding: const EdgeInsets.only(left: 0, right: 0, top: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.orange.shade500,
                        size: 15,
                      ),
                      Text(
                        "${widget.postData.province}",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0, right: 0, top: 8),
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
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0, right: 0, top: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.cancel_outlined,
                                color: Colors.red.shade500,
                                size: 15,
                              ),
                              Text(
                                ' Đã hết hạn',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.orange.shade500,
                            minimumSize: Size(30, 30)),
                        onPressed: () async {
                          var result = await PostServiceRepository()
                              .reNewPostAPI(
                                  idPost: widget.postData.id, date: 7);
                          if (result.statusCode == 200 ||
                              result.statusCode == 201) {
                            Get.snackbar(
                                "Thành công", "Gia hạn bài viết thành công",
                                duration: Duration(seconds: 3),
                                margin: EdgeInsets.all(6),
                                backgroundColor: Colors.white,
                                leftBarIndicatorColor: Colors.green,
                                colorText: Colors.black,
                                snackPosition: SnackPosition.TOP);
                            // await widget.loadData;
                            loadData();
                          } else {
                            Get.snackbar(
                              "Thất bại",
                              "Gia hạn bài viết thất bại",
                              duration: Duration(seconds: 3),
                              margin: EdgeInsets.all(6),
                              backgroundColor: Colors.white,
                              leftBarIndicatorColor: Colors.red,
                              colorText: Colors.black,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                          print("Yêu cầu lại");
                        },
                        child: Text(
                          "Gia hạn",
                          style: TextStyle(fontSize: 12),
                        )),
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
