import 'dart:async';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/models/tab_model.dart';
import 'package:chotot_app/src/pages/managePost/delete_screen.dart';
import 'package:chotot_app/src/pages/managePost/overtime_screen.dart';
import 'package:chotot_app/src/pages/managePost/reject_screen.dart';
import 'package:chotot_app/src/pages/managePost/showing_screen.dart';
import 'package:chotot_app/src/pages/managePost/wait_review_screen.dart';
import 'package:flutter/material.dart';

class ManagePostScreen extends StatefulWidget {
  const ManagePostScreen({Key? key}) : super(key: key);

  @override
  State<ManagePostScreen> createState() => _ManagePostScreenState();
}

// Các status code:
// 0 : Chờ được duyệt
// 1 : Từ chối duyệt
// 2 : Đang hiển thị
// 3 : Hủy
// 4 : Hết hạn

class _ManagePostScreenState extends State<ManagePostScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamController<List<PostModel>> postWaitConfirmController =
      StreamController<List<PostModel>>.broadcast();
  StreamController<List<PostModel>> postRejectController =
      StreamController<List<PostModel>>.broadcast();
  StreamController<List<PostModel>> postShowingController =
      StreamController<List<PostModel>>();
  StreamController<List<PostModel>> postDeleteController =
      StreamController<List<PostModel>>.broadcast();
  StreamController<List<PostModel>> postOvertimeController =
      StreamController<List<PostModel>>.broadcast();
  List<TabModel> _tabsValue = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabsValue = [
      TabModel(title: "Chờ duyệt", icon: Icons.history, width: 80),
      TabModel(title: "Bị từ chối", icon: Icons.cancel_outlined, width: 100),
      TabModel(title: "Đang hiển thị", icon: Icons.check_circle, width: 100),
      TabModel(title: "Hủy", icon: Icons.remove_circle, width: 70),
      TabModel(title: "Hết hạn", icon: Icons.info_outline, width: 70),
    ];
  }

  @override
  void dispose() {
    postWaitConfirmController.close();
    postRejectController.close();
    postShowingController.close();
    postDeleteController.close();
    postOvertimeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quản lí tin đăng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          automaticallyImplyLeading: false, // bỏ nút back
          elevation: 20,
          titleSpacing: 20,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 30,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                  size: 30,
                ))
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.white,
            indicatorColor: Colors.black,
            tabs: [
              ..._tabsValue.map(
                (e) => Container(
                  width: e.width,
                  child: Tab(
                    text: e.title,
                    icon: Icon(e.icon),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(controller: _tabController, children: [
            WaitReviewScreen(
              postWaitConfirmController: postWaitConfirmController,
            ),
            RejectPostScreen(
              postRejectController: postRejectController,
            ),
            ShowingPostScreen(
                // postShowingController: postShowingController,
                ),
            DeletePostScreen(
              postDeleteController: postDeleteController,
            ),
            OvertimePostScreen(
              postOvertimeController: postOvertimeController,
            ),
          ]),
        ),
      ),
    );
  }
}
