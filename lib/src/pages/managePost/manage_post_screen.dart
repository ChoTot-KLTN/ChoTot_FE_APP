import 'package:chotot_app/src/models/tab_model.dart';
import 'package:flutter/material.dart';

class ManagePostScreen extends StatefulWidget {
  const ManagePostScreen({Key? key}) : super(key: key);

  @override
  State<ManagePostScreen> createState() => _ManagePostScreenState();
}

class _ManagePostScreenState extends State<ManagePostScreen> {
  List<TabModel> _tabsValue = [];
  @override
  void initState() {
    super.initState();
    _tabsValue = [
      TabModel(title: "Đang hiển thị", icon: Icons.history, width: 100),
      TabModel(title: "bị từ chối", icon: Icons.cancel_outlined, width: 100),
      TabModel(title: "Cần thanh toán", icon: Icons.payment, width: 100),
      TabModel(title: "Tin nháp", icon: Icons.check_circle, width: 70),
      TabModel(title: "Khác", icon: Icons.info_outline, width: 70),
    ];
  }

  Widget state1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Đang hiển thị",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget state2(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Bị từ chối",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget state3(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Cần thành toán",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget state4(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Tin nháp",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget state5(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Khác",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          child: TabBarView(children: [
            state1(context),
            state2(context),
            state3(context),
            state4(context),
            state5(context),
          ]),
        ),
      ),
    );
  }
}
