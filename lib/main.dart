import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psite/pages/base_page.dart';
import 'package:psite/pages/channel_page.dart';
import 'package:psite/pages/home_page.dart';
import 'package:psite/pages/shopping_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: BasePage(),
        routes: {
          "home": (BuildContext context) => HomePage(),
          "chancel": (BuildContext context) => HomePage(),
          "follow": (BuildContext context) => ChannelPage(),
          "shopping": (BuildContext context) => ShoppingPage()
        },
      ),
    );
  }
}
