import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget state1(BuildContext context) {
    return Container(
      child: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('I LOVE YOU'),
            );
          },
          itemCount: 50,
        ),
      ),
    );
  }

  Widget state2(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Tab2'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông báo",
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
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black,
                        indicatorColor: Colors.orange.shade500,
                        indicatorWeight: 2,
                        tabs: [
                          Tab(
                            text: "HOAT ĐỘNG",
                          ),
                          Tab(
                            text: "TIN MỚI",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: tabController,
                children: [state1(context), state2(context)],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
