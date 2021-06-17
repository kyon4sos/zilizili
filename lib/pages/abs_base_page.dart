import 'package:flutter/material.dart';

abstract class AbsBasePage extends StatefulWidget {
  Widget buildAppbarAction();

  BottomNavigationBarItem buildNavBarItem();
}

class _AbsBasePageState extends State<AbsBasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
