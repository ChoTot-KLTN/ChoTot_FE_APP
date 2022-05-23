import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class PaymentPaypalScreen extends StatefulWidget {
  final String url;

  PaymentPaypalScreen({required this.url});
  @override
  State<StatefulWidget> createState() {
    return _PaymentPaypalScreenState();
  }
}

class _PaymentPaypalScreenState extends State<PaymentPaypalScreen> {
  late WebViewController controller;
  String status = "success";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thanh toán Online"),
        actions: [
          IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: Icon(Icons.refresh))
        ],
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {},
        onPageStarted: (url) {},
        onPageFinished: (page) async {
          print("Current page2: " + page.toString());
          if (page.contains('/success')) {
            setState(() {
              status = "success";
            });

            showDialog(
                context: context,
                builder: (contex) => CustomDialog(
                    title: "Thanh toán thành công",
                    description: "Bạn đã nâng cấp tin thành công",
                    isSuccess: status));
          } else if (page.contains('/cancel')) {
            setState(() {
              status = "cancel";
            });
            showDialog(
                context: context,
                builder: (contex) => CustomDialog(
                    title: "Thanh toán thất bại",
                    description: "Vui lòng kiểm tra số dư trong ví",
                    isSuccess: status));
          }
        },
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String isSuccess;

  CustomDialog(
      {required this.title,
      required this.description,
      required this.isSuccess});
  dialogConten(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 100, left: 16, bottom: 16, right: 16),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(description, style: TextStyle(fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[400]),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, 'home');
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: (isSuccess == "success")
                ? Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green[400],
                  )
                : Icon(
                    Icons.cancel_rounded,
                    size: 80,
                    color: Colors.red[400],
                  )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: dialogConten(context),
    );
  }
}
