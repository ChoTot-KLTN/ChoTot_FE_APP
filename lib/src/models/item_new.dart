import 'package:flutter/material.dart';

import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ItemNews {
  final Color color;
  final IconData iconData;
  final String title;
  final Callback function;

  ItemNews(
      {required this.color,
      required this.iconData,
      required this.title,
      required this.function});
}
