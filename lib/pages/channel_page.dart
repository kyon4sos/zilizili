import 'package:flutter/material.dart';
import 'package:psite/pages/abs_base_page.dart';

class ChannelPage extends AbsBasePage {
  @override
  Widget buildAppbarAction() {
    // TODO: implement buildAppbarAction
    return Icon(Icons.airplay);
  }

  @override
  BottomNavigationBarItem buildNavBarItem() {
    // TODO: implement buildNavBarItem
    return BottomNavigationBarItem(
        label: "频道", icon: Icon(Icons.grain_outlined));
  }

  @override
  State<StatefulWidget> createState() => _ChannelPageState();

  @override
  Widget buildAppbarTitle() {
    // TODO: implement buildAppbarTitle
    return Text("频道");
  }
}

class _ChannelPageState extends State<ChannelPage> {
  final double margin = 8;
  @override
  Widget build(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width / 2) - margin * 2;
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: [
        Container(
          color: Colors.pinkAccent,
          width: width,
          height: 100,
          child: Text("频道"),
        ),
        Container(
          color: Colors.pinkAccent,
          width: width,
          height: 100,
          child: Text("频道"),
        ),
        Container(
          color: Colors.pinkAccent,
          width: width,
          height: 100,
          child: Text("频道"),
        ),
        Container(
          color: Colors.pinkAccent,
          width: width,
          height: 100,
          child: Text("频道"),
        ),
        Container(
          color: Colors.pinkAccent,
          width: width,
          height: 100,
          child: Text("频道"),
        ),
      ],
    );
  }
}

// {"label": "首页", "icon": Icon(Icons.home), "router": "home"},
// {"label": "频道", "icon": Icon(Icons.airplay), "router": "channel"},
// {"label": "动态", "icon": Icon(Icons.widgets_outlined), "router": "follow"},
// {
// "label": "会员购",
// "icon": Icon(Icons.shopping_cart_outlined),
// "router": "shopping"
// },
