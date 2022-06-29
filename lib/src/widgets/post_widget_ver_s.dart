import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_apartment.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_bicyle.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_car.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_ground.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_house.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_laptop.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_motelroom.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_motorbike.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_office.dart';
import 'package:chotot_app/src/pages/detail_post/detail_post_phone.dart';
import 'package:flutter/material.dart';
import 'package:chotot_app/src/common/base_convert.dart';
import 'package:marquee/marquee.dart';
import 'package:get/get.dart';

class PostWidgetVerS extends StatefulWidget {
  const PostWidgetVerS({Key? key, required this.postData}) : super(key: key);
  final PostModel postData;

  @override
  State<PostWidgetVerS> createState() => _PostWidgetVerSState();
}

class _PostWidgetVerSState extends State<PostWidgetVerS> {
  List<int> dateOfMonth = [31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
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
    return GestureDetector(
      onTap: () {
        if (widget.postData.onModel.trim() == "PostCar") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostCarScreen(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostGround") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostGroundScreen(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostApartment") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostAparment(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostMotelRoom") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostMotelroom(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostOffice") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostOffice(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostPhone") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostPhone(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostLaptop") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostlaptop(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostMotorbike") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostMotorbike(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostBicycle") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostBicyle(
                    postdetail: widget.postData,
                  )));
          return;
        } else if (widget.postData.onModel.trim() == "PostHouse") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostHouse(
                    postdetail: widget.postData,
                  )));
          return;
        }
        print("Khác loại post1: ${widget.postData.onModel}");
      },
      child: Container(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          (widget.postData.prePrice.toString()).toVND(),
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
                          widget.postData.province,
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
                  widget.postData.isAdvertised
                      ? Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.brightness_auto_outlined,
                                  color: Colors.orange,
                                  size: 18,
                                ),
                                Text(
                                  " Ưu tiên",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
