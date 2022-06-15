import 'dart:math';

import 'package:chotot_app/src/models/owner_post_model.dart';

import 'package:chotot_app/src/repositories/user_repo.dart';
import 'package:chotot_app/src/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class RatingView extends StatefulWidget {
  RatingView({Key? key, required this.idOwner, required this.ownerPostModel})
      : super(key: key);
  final String idOwner;
  OwnerPostModel? ownerPostModel;
  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  @override
  void initState() {
    super.initState();
  }

  var _ratingPageController = PageController();
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Container(
            height: max(300, MediaQuery.of(context).size.height * 0.3),
            child: PageView(
              controller: _ratingPageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                buildTextRating(context),
                // buildButton(),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  var result = await UserRepository()
                      .createRating(idOwner: widget.idOwner, rate: rate);
                  if (result.statusCode == 200) {
                    var updateUserRate = await UserRepository()
                        .getUserInforAPI(userId: widget.idOwner);
                    if (updateUserRate != null) {
                      setState(() {
                        widget.ownerPostModel = updateUserRate;
                      });
                    }
                    showDialoga(
                        title: "Thành công",
                        subTitle: "Đánh giá thành công",
                        status: "Success");
                  } else {
                    showDialoga(
                        title: "Thất bại",
                        subTitle: "Đánh giá thất bại",
                        status: "Fail");
                  }
                },
                child: Container(
                  height: 50,
                  color: Colors.orange,
                  child: Center(child: Text('Done')),
                ),
              )),
          Positioned(
            top: 5,
            right: 0,
            child: buildCancel(context),
          )
        ],
      ),
    );
  }

  buildTextRating(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Đánh giá",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Đánh giá càng cao \n độ uy tín càng lớn",
          style: TextStyle(fontSize: 15),
        ),
        RatingBar.builder(
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // setState(() {
            //   rate = rating;
            // });
          },
        ),
      ],
    );
  }

  buildCancel(context) {
    return Container(
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.cancel),
      ),
    );
  }
}
