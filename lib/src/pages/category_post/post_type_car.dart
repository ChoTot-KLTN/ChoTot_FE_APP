import 'package:flutter/material.dart';

class PostTypeCarScreen extends StatefulWidget {
  const PostTypeCarScreen({Key? key}) : super(key: key);

  @override
  State<PostTypeCarScreen> createState() => _PostTypeCarScreenState();
}

class _PostTypeCarScreenState extends State<PostTypeCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xe cộ"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Car post"),
        ),
      ),
    );
  }
}
