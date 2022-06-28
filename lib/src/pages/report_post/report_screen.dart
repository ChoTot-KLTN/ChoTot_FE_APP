import 'package:chotot_app/src/models/user_model.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:chotot_app/src/repositories/report_repository.dart';
import 'package:chotot_app/src/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class ReportPost extends StatefulWidget {
  const ReportPost(
      {Key? key,
      required this.postID,
      required this.nameOwner,
      required this.postTitle})
      : super(key: key);
  final String postID;
  final String nameOwner;
  final String postTitle;
  @override
  State<ReportPost> createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
  TextEditingController report = TextEditingController();
  late UserModel user;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    user = userProvider.getUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo vi phạm"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Image.asset(
                      'assets/images/reporticon.png',
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Bài viết: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                        child: Text(
                      widget.postTitle,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Tác giả: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                        child: Text(
                      widget.nameOwner,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    controller: report,
                    decoration: InputDecoration(hintText: "Báo cáo..."),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Vui lòng nhập lí do báo cáo";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade300,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var result = await ReportRepository().reportPostAPI(
                              idPost: widget.postID,
                              idReporter: user.id,
                              nameReporter: user.name,
                              avatar: user.avatar,
                              reason: report.text);
                          if (result.statusCode == 200) {
                            setState(() {
                              report.text = "";
                            });
                            showDialoga(
                                title: "Thành công",
                                subTitle: "Gửi báo cáo thành công",
                                status: "Success");
                          } else {
                            showDialoga(
                                title: "Thất bại",
                                subTitle: "Bạn đã báo cáo bài viết rồi",
                                status: "Fail");
                          }
                        }
                      },
                      icon: Icon(Icons.report_outlined),
                      label: Text("Báo cáo")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
