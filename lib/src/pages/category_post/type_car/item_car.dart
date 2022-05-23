import 'package:flutter/material.dart';

class ItemCarsWidget extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final String title;

  const ItemCarsWidget(
      {Key? key,
      required this.color,
      required this.iconData,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(title);
      },
      child: SizedBox(
        // height: 90,
        width: 90,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: color),
              child: Center(
                child: Icon(
                  iconData,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 30,
              width: 60,
              child: Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
