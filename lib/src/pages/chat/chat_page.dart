import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var token = GetStorage().read("token");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(token.toString()),
      ),
    );
  }
}
