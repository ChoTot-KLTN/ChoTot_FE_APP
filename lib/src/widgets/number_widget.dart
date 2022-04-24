import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  Widget buildButton(BuildContext context, String title, IconData icon) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 8,
          ),
          Icon(icon)
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(color: Colors.black),
      height: 35,
      width: 1,
      child: VerticalDivider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(context, "Bán chuyên", Icons.card_giftcard),
        buildDivider(),
        buildButton(context, "Đánh giá", Icons.comment),
        buildDivider(),
        buildButton(context, "Phản hồi chat", Icons.kayaking_outlined),
      ],
    );
  }
}
