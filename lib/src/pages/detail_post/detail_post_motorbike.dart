import 'dart:async';
import 'dart:convert';

import 'package:chotot_app/src/models/comment_model.dart';
import 'package:chotot_app/src/models/post/motorbike_model.dart';
import 'package:chotot_app/src/models/post/post_model.dart';
import 'package:chotot_app/src/repositories/comment_repo.dart';
import 'package:chotot_app/src/repositories/post_service_repo.dart';
import 'package:chotot_app/src/widgets/comment_widget.dart';
import 'package:chotot_app/src/widgets/number_widget.dart';
import 'package:chotot_app/src/widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chotot_app/src/common/base_convert.dart';
import 'package:rxdart/rxdart.dart';

class DetailPostMotorbike extends StatefulWidget {
  const DetailPostMotorbike({Key? key, this.postdetail}) : super(key: key);
  final PostModel? postdetail;
  @override
  State<DetailPostMotorbike> createState() => _DetailPostMotorbikeState();
}

class _DetailPostMotorbikeState extends State<DetailPostMotorbike> {
  int currentIndex = 0;
  List<String>? listImgs = []; // list Img use to Slider
  PageController pageController = PageController(initialPage: 0);
  String avatar = "a";
  PostMotorbikeModel? postMotorbikeModel;
  bool isLoading = true;
  List<int> dateOfMonth = [31, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  var streamController = BehaviorSubject<List<PostModel>>();

  List<PostModel> listPostRecommend = [];
  var listCommentController = BehaviorSubject<List<CommentModel>>();
  TextEditingController comment = TextEditingController();
  getPostDetail() async {
    try {
      var result =
          await PostServiceRepository().getPostDetail1(widget.postdetail!.id);
      if (result.statusCode == 200) {
        var data = jsonDecode(result.body)['data'];
        var jsonResponse = PostMotorbikeModel.fromMap(data);
        setState(() {
          postMotorbikeModel = jsonResponse;
          isLoading = false;
        });
      } else {
        print("Lỗi 404 ");
      }
    } catch (err) {
      print(err.toString());
    }
  }

  getListRecommend() async {
    var listPost = await PostServiceRepository().getAllPostWithType(
        page: 0, limit: 10, status: 2, type: "PostMotorbike");
    if (listPost.length == 0) {
      streamController.add([]);
    } else {
      // listPostController.add(listTemp);
      listPostRecommend.addAll(listPost);
      listPostRecommend
          .removeWhere((element) => element.id == widget.postdetail!.id);
      streamController.add(listPostRecommend);
    }
  }

  getListComment() async {
    var listComment =
        await CommentRepository().getAllComment(postID: widget.postdetail!.id);
    if (listComment.length == 0) {
      listCommentController.add([]);
    } else {
      listCommentController.add(listComment);
    }
  }

  @override
  void initState() {
    listImgs = widget.postdetail!.image;
    getPostDetail();
    getListRecommend();
    getListComment();
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    listCommentController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? dateStart = widget.postdetail!.dateStartPost;
    // DateTime? dateEnd = widget.postData.dateEndPost;
    int monthStart = widget.postdetail!.dateStartPost!.month;
    int dayStart = widget.postdetail!.dateStartPost!.day;
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                print("Love");
              },
              icon: Icon(Icons.favorite_outline)),
          IconButton(
              onPressed: () {
                print("Shared");
              },
              icon: Icon(Icons.share_outlined)),
          IconButton(
              onPressed: () {
                print("More");
              },
              icon: Icon(Icons.more_vert_outlined)),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 0.1,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: Colors.black26),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildItemBottom(
                  Icons.phone, "Gọi điện", Colors.white, Colors.green.shade600),
              buildItemBottom(
                  Icons.sms_outlined, "Gửi SMS", Colors.green.shade500),
              buildItemBottom(
                  Icons.message_outlined, "Chat", Colors.green.shade500),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: PageView.builder(
                    itemCount: listImgs!.length,
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        listImgs![index],
                        fit: BoxFit.cover,
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
                      );
                    }),
              ),
              Positioned(
                  // khúc này tạo một hàng các nút cho người dùng bấm chọn hình trên slider
                  bottom: 10.0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(listImgs!.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(microseconds: 400),
                        height: 8.0,
                        width: currentIndex == index ? 24.0 : 8.0,
                        margin: EdgeInsets.only(right: 4.0),
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      );
                    }).toList(),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.postdetail!.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((widget.postdetail!.prePrice.toString()).toVND(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red)),
                        SizedBox(
                          height: 6,
                        ),
                        date == 0
                            ? Text(
                                ' - $timeActive giờ trước',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey),
                              )
                            : Text(
                                ' - $date ngày trước',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.red),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lưu tin",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: avatar != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network("aw", fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                            return Center(child: Icon(Icons.person));
                          }),
                        )
                      : null,
                ),
                Column(
                  children: [
                    Text(
                      widget.postdetail!.nameOfPoster,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.drag_indicator,
                          color: Colors.grey,
                        ),
                        Text(
                          "Hoạt động 8 phút trước",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: Colors.orange.shade500),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text("Xem trang"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          NumberWidget(),
          Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
            width: MediaQuery.of(context).size.width - 20,
            child: Text(
              widget.postdetail!.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
            child: Text(
              "Liên hệ ngay: 0123456789",
              style: TextStyle(color: Colors.blue.shade500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 20),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      buildDetail(Icons.payment_outlined,
                          "Trạng thái: ${postMotorbikeModel!.type}"),
                      buildDetail(
                          Icons.flag, "Hãng: ${postMotorbikeModel!.brand}"),
                      buildDetail(Icons.calendar_view_month,
                          "Năm đăng kí: ${postMotorbikeModel!.yearOfRegistration}"),
                      buildDetail(Icons.edit_road,
                          "Số km đã đi: ${postMotorbikeModel!.numberOfKm}"),
                      buildDetail(Icons.history_edu,
                          "Tình trạng: ${postMotorbikeModel!.statusMotorbike}"),
                      buildDetail(Icons.category_outlined,
                          "Loại xe: ${postMotorbikeModel!.typeMotorbike}"),
                      buildDetail(Icons.settings_suggest_outlined,
                          "Dung tích xe: ${postMotorbikeModel!.capacity}"),
                    ],
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          buildTilte("Hỏi người bán qua chat"),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 0),
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  buildItemChat("Xe này còn không ạ?"),
                  SizedBox(
                    width: 5,
                  ),
                  buildItemChat("Tình trạng giấy tờ như thế nào ạ?"),
                  SizedBox(
                    width: 5,
                  ),
                  buildItemChat("Tôi có thể trả góp không?"),
                  SizedBox(
                    width: 5,
                  ),
                  buildItemChat("Xe đã qua bao nhiêu đời chủ"),
                ],
              ),
            ),
          ),
          buildTilte("Công cụ và dịch vụ"),
          SizedBox(
            height: 20,
          ),
          buildTilte("Khu vực"),
          Padding(
            padding: const EdgeInsets.only(top: 0, right: 10, left: 20),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: isLoading
                      ? Text("Địa chỉ")
                      : Text(
                          postMotorbikeModel!.address.detail +
                              ", " +
                              postMotorbikeModel!.address.village +
                              ", " +
                              postMotorbikeModel!.address.district +
                              ", " +
                              postMotorbikeModel!.address.province,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildTilte("Các tin liên quan"),
          Container(
              height: 350,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
              ),
              child: StreamBuilder<List<PostModel>>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.length == 0
                        ? Center(
                            child: Text("không có tin đăng nào"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return PostCard(
                                postData: snapshot.data![index],
                              );
                            },
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                          );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Lỗi"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
          buildTilte("Bình luận"),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                          hintText: "Nhập bình luận...",
                          contentPadding: const EdgeInsets.only(left: 10)),
                      onSubmitted: (content) {
                        print(content);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () async {
                        print("Send cmt");
                        var sendCMT = await CommentRepository().registerComment(
                            idPost: widget.postdetail!.id, text: comment.text);
                        if (sendCMT.statusCode == 200) {
                          // showDialoga(
                          //     title: "Thành công",
                          //     subTitle: "Gửi yêu cầu thành công",
                          //     status: "Success");
                          // await widget.loadData;
                          getListComment();
                        } else {
                          // showDialoga(
                          //     title: "Thất bại",
                          //     subTitle: "Gửi yêu cầu thất bại",
                          //     status: "Fail");
                        }
                        setState(() {
                          comment.text = "";
                        });
                      },
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.orange.shade500,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 500,
            child: StreamBuilder<List<CommentModel>>(
                stream: listCommentController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.length == 0
                        ? Center(
                            child: Text("Chưa có bình luận"),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                commentDetail: snapshot.data![index],
                                commentStream: listCommentController,
                                postID: widget.postdetail!.id,
                              );
                            },
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.all(10),
                            // scrollDirection: Axis.horizontal,
                          );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Lỗi"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        ],
      )),
    );
  }

  Widget buildItemChat(String title) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.orange),
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Text(title),
      ),
    );
  }

  Widget buildTilte(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }

  Widget buildDetail(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 10,
        ),
        Text(title)
      ],
    );
  }

  Widget buildItemBottom(IconData icon, String title, Color color,
      [Color? bg]) {
    return GestureDetector(
      onTap: () {
        print(title);
      },
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width / 3 - 5,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(color: bg != null ? bg : Colors.white),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
