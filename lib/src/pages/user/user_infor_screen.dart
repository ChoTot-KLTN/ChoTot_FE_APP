import 'package:chotot_app/src/models/rating_model.dart';
import 'package:chotot_app/src/models/user_model.dart';
import 'package:chotot_app/src/pages/user/change_password_screen.dart';
import 'package:chotot_app/src/pages/user/update_infor_screen.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:chotot_app/src/repositories/user_repo.dart';
import 'package:chotot_app/src/widgets/header_widget.dart';
import 'package:chotot_app/src/widgets/number_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _drawerIconSize = 24;
  late UserModel user;
  RatingModel? ratingModel;
  @override
  void initState() {
    super.initState();
    user = userProvider.getUser!;
    getDataRating();
  }

  getDataRating() async {
    var result = await UserRepository().getUserRating(idOwner: user.id);
    if (result != null) {
      setState(() {
        ratingModel = result;
      });
    }
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
          "Thông tin cá nhân",
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
            margin: EdgeInsets.only(top: 14, right: 14),
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
                    padding: EdgeInsets.all(1),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80.0,
              child: HeaderWidget(100, false, Icons.house_rounded),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              // margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: 70,
                          width: 70,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 0.5, color: Colors.orange.shade400),
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(
                            //       color: Colors.black26,
                            //       blurRadius: 20,
                            //       offset: const Offset(5, 5))
                            // ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          )),
                      Positioned(
                          height: 110,
                          width: 110,
                          child: IconButton(
                            onPressed: () {
                              print("pick ảnh");
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 21,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                  ratingModel == null
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Đánh giá  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            RatingBarIndicator(
                              rating: ratingModel!.rate == null
                                  ? 0
                                  : ratingModel!.rate,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 28,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              "  (${ratingModel!.count} lượt đánh giá)",
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
                            fontWeight: FontWeight.bold, fontSize: 17),
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
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    leading: Icon(Icons.my_location),
                                    title: Text("Địa chỉ"),
                                    subtitle: Text(
                                        "${user.address.detail}, ${user.address.province}"),
                                    onTap: () {},
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.email,
                                      color: Colors.red,
                                    ),
                                    title: Text("Email"),
                                    subtitle: Text("${user.email}"),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                    title: Text("Phone"),
                                    subtitle: Text("${user.phone}"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade300),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateInfoScreen()));
                    },
                    icon: Icon(Icons.perm_contact_calendar_sharp),
                    label: Text("Chỉnh sửa")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Đổi mật khẩu")),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
