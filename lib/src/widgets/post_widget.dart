import 'package:chotot_app/src/common/base_convert.dart';
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
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  const PostCard({required this.postData, Key? key}) : super(key: key);
  final PostModel postData;
  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // String dateStart = DateFormat("d/MM/y -").format(DateTime.now());
  // String dateEnd = DateFormat(" d/MM/y").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    int l = widget.postData.image.length;
    String img = widget.postData.image[l - 1];
    DateTime? dateStart = widget.postData.dateStartPost;
    DateTime? dateEnd = widget.postData.dateEndPost;
    var dateNow = DateTime.now();
    int date = dateNow.day - dateStart!.day;
    int timeActive = 0;
    if (date == 0) {
      timeActive = dateNow.hour - dateStart.hour;
    } else {
      timeActive = date;
    }
    // var format = DateFormat.yMd('ar');
    // var dateString = format.format(DateTime.now());
    return GestureDetector(
      onTap: () {
        if (widget.postData.onModel == "PostCar") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailPostCarScreen(
                    postdetail: widget.postData,
                  )));
        }
        if (widget.postData.onModel == "PostGround") {
          Get.to(() => DetailPostGroundScreen(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostApartment") {
          Get.to(() => DetailPostAparment(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostMotelRoom") {
          Get.to(() => DetailPostMotelroom(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostOffice") {
          Get.to(() => DetailPostOffice(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostPhone") {
          Get.to(() => DetailPostPhone(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostLaptop") {
          Get.to(() => DetailPostlaptop(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostMotorbike") {
          Get.to(() => DetailPostMotorbike(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostBicycle") {
          Get.to(() => DetailPostBicyle(
                postdetail: widget.postData,
              ));
        }
        if (widget.postData.onModel == "PostHouse") {
          Get.to(() => DetailPostHouse(
                postdetail: widget.postData,
              ));
          print("Khác loại post");
        }
      },
      child: Container(
        width: 180,
        height: 290,
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, right: 5),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                    height: 180,
                    width: 180,
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
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      widget.postData.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 4),
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
                    ' -${widget.postData.province}',
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
          ],
        ),
      ),
    );
  }
}
