import 'dart:async';

import 'package:chotot_app/src/models/owner_post_model.dart';
import 'package:chotot_app/src/models/user_model.dart';
import 'package:chotot_app/src/pages/user/rating_view_dialog.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:chotot_app/src/repositories/user_repo.dart';
import 'package:chotot_app/src/widgets/header_widget.dart';
import 'package:chotot_app/src/widgets/number_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

class OwnerInforScreen extends StatefulWidget {
  const OwnerInforScreen({Key? key, required this.idOwner}) : super(key: key);
  final String idOwner;
  @override
  State<OwnerInforScreen> createState() => _OwnerInforScreenState();
}

class _OwnerInforScreenState extends State<OwnerInforScreen> {
  double _drawerIconSize = 24;

  UserModel? currentUser;
  OwnerPostModel? ownerPostModel;
  var ownerPostModelController = BehaviorSubject<OwnerPostModel>();
  getdataOwner() async {
    var result = await UserRepository().getUserInforAPI(userId: widget.idOwner);
    if (result != null) {
      ownerPostModelController.sink.add(result);
      print("Has data");
      setState(() {
        ownerPostModel = result;
      });
    } else {
      ownerPostModelController.sink.addError({});
    }
  }

  callback(userUpdate) {
    setState(() {
      ownerPostModel = userUpdate;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser = userProvider.getUser;
    });
    getdataOwner();
  }

  @override
  void dispose() {
    ownerPostModelController.close();
    super.dispose();
  }

  Widget builIcon(IconData icon) {
    return CircleAvatar(
      radius: 25,
      child: Center(
        child: Icon(
          icon,
          size: 32,
          color: Colors.blue.shade500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Thông tin người bán",
            style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ])),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 14, right: 14),
              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        print("Xem notification");
                      },
                      icon: Icon(Icons.notifications)),
                  Positioned(
                    top: 2,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints:
                          BoxConstraints(minWidth: 14.0, minHeight: 14.0),
                      child: Text(
                        "1",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
        body: StreamBuilder<OwnerPostModel>(
            stream: ownerPostModelController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 100.0,
                        child: HeaderWidget(100, false, Icons.house_rounded),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        // margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 10.0, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 20,
                                        offset: const Offset(5, 5))
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network("aw", fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.grey.shade800,
                                      backgroundImage: AssetImage(
                                          'assets/images/avatar.png'),
                                    );
                                  }),
                                )),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              snapshot.data!.infor.name,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                builIcon(FontAwesomeIcons.gift),
                                SizedBox(
                                  width: 5,
                                ),
                                builIcon(FontAwesomeIcons.facebook),
                                SizedBox(
                                  width: 5,
                                ),
                                builIcon(FontAwesomeIcons.instagram),
                                SizedBox(
                                  width: 5,
                                ),
                                builIcon(FontAwesomeIcons.twitter),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            NumberWidget(),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (GetStorage().read('token') != null) {
                                      if (currentUser!.id != widget.idOwner) {
                                        openRatingDialog(
                                            context,
                                            widget.idOwner,
                                            ownerPostModelController);
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(right: 5),
                                    height: 30,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.orange.shade500),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      "Đánh giá  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: snapshot.data!.totalRate,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 28,
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                  "  (${snapshot.data!.count} lượt đánh giá)",
                                  style: TextStyle(color: Colors.grey.shade500),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Tổng số bài đăng: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Text(
                                  "8",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              child: Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        ...ListTile.divideTiles(
                                          color: Colors.grey,
                                          tiles: [
                                            ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4),
                                              leading: Icon(Icons.my_location),
                                              title: Text("Địa chỉ"),
                                              subtitle: Text(
                                                  "${snapshot.data!.infor.address.detail}, ${snapshot.data!.infor.address.province}"),
                                              onTap: () {},
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.email,
                                                color: Colors.red,
                                              ),
                                              title: Text("Email"),
                                              subtitle: Text(
                                                  "${snapshot.data!.infor.email}"),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.phone,
                                                color: Colors.green,
                                              ),
                                              title: Text("Phone"),
                                              subtitle: Text(
                                                  "${snapshot.data!.infor.phone}"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Không load được"),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  openRatingDialog(BuildContext context, String idOwner,
      StreamController<OwnerPostModel> streamOwnerModel) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: RatingView(
              idOwner: idOwner,
              streamOwnerModel: streamOwnerModel,
            ),
          );
        });
  }
}
