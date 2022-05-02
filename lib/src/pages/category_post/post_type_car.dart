import 'dart:async';

import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class PostTypeCarScreen extends StatefulWidget {
  const PostTypeCarScreen({Key? key}) : super(key: key);

  @override
  State<PostTypeCarScreen> createState() => _PostTypeCarScreenState();
}

class _PostTypeCarScreenState extends State<PostTypeCarScreen> {
  StreamController<List<PostModel>> stream =
      StreamController<List<PostModel>>();
  loadData() async {
    var result = await PostServiceRepository().getAllPost(page: 0, limit: 10);
    if (result.length == 0) {
      stream.add([]);
    } else {
      stream.add(result);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xe cộ"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.grey,
            height: 50,
            child: Marquee(
              text: 'Some sample text that takes some space.',
              style: TextStyle(fontWeight: FontWeight.bold),
              // scrollAxis: Axis.horizontal,
              // crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 100.0,
              pauseAfterRound: Duration(seconds: 1),
              showFadingOnlyWhenScrolling: true,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
              numberOfRounds: 3,
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
        ),
      ),
    );
  }
}



/*
StreamBuilder<List<PostModel>>(
          stream: stream.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return PostCard(
                    postData: snapshot.data![index],
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }
            if (snapshot.hasError) {
              Center(
                child: Text("Lỗi"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
 */