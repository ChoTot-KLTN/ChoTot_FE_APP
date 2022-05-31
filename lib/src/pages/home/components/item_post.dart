import 'package:chotot_app/src/models/category_model.dart';
import 'package:chotot_app/src/pages/category_post/type_BDS/post_type_BDS.dart';
import 'package:chotot_app/src/pages/category_post/type_Device/post_type_device.dart';
import 'package:chotot_app/src/pages/category_post/type_car/post_type_car.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPostWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  const ItemPostWidget({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (categoryModel.id == "2") {
          Get.to(() => PostTypeCarScreen());
        } else if (categoryModel.id == '3') {
          Get.to(() => PostTypeDeviceScreen());
        } else if (categoryModel.id == '1') {
          Get.to(() => PostTypeBDSScreen());
        } else {
          print('Khác loại category');
        }
      },
      child: SizedBox(
        width: 150,
        height: 100,
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                categoryModel.image,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Center(child: Icon(Icons.error));
                },
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          SizedBox(
            width: 150,
            child: Text(
              categoryModel.name,
              style: TextStyle(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
