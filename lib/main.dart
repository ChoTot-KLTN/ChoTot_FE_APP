import 'package:chotot_app/src/app.dart';
import 'package:chotot_app/src/pages/home/home_nav_page.dart';
import 'package:chotot_app/src/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

int time = 2;

class MyApp extends StatelessWidget {
  final Color _pimaryColors = HexColor('#FFA500');
  final Color _accentColor = HexColor('#F0E68C');
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
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
        routes: {
          'home': (context) => MyHomePage(),
        },
      ),
    );
  }
}
