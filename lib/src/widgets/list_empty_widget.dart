import 'package:flutter/material.dart';

class ListEmptyWidget extends StatelessWidget {
  const ListEmptyWidget({Key? key, this.status = " "}) : super(key: key);
  final String status;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/listempty.png",
          width: 160,
        ),
        SizedBox(height: 20),
        Text(status,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                fontSize: 14)),
      ],
    );
  }
}
