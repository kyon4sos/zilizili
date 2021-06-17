import 'package:flutter/material.dart';
import 'package:psite/pages/abs_base_page.dart';

class FollowPage extends AbsBasePage {
  @override
  Widget buildAppbarAction() {
    // TODO: implement buildAppbarAction
    return IconButton(onPressed: onPressed, icon: Icon(Icons.share));
  }

  @override
  Widget buildBody() {
    // TODO: implement buildBody
    return Center(
      child: Text("动态"),
    );
  }

  @override
  BottomNavigationBarItem buildNavBarItem() {
    // TODO: implement buildNavBarItem
    return BottomNavigationBarItem(
        icon: Icon(Icons.app_registration), label: "动态");
  }

  onPressed() {}

  @override
  State<StatefulWidget> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("动态"),
    );
  }
}
