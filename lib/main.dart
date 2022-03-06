import 'package:chotot_app/src/app.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

int time = 2;

class MyApp extends StatelessWidget {
  final Color _pimaryColors = HexColor('#FFA500');
  final Color _accentColor = HexColor('#F0E68C');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => userProvider)
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // primarySwatch: Colors.blue,
            primaryColor: _pimaryColors,
            accentColor: _accentColor),
        home: AppChoTot(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
