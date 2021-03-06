import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psite/pages/abs_base_page.dart';

class ShoppingPage extends AbsBasePage {
  @override
  Widget buildAppbarAction() {
    // TODO: implement buildAppbarAction
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: onPressed, icon: FaIcon(FontAwesomeIcons.star)),
                IconButton(
                    onPressed: onPressed,
                    icon: FaIcon(FontAwesomeIcons.cartArrowDown)),
                IconButton(
                    onPressed: onPressed,
                    icon: FaIcon(FontAwesomeIcons.userCircle)),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  BottomNavigationBarItem buildNavBarItem() {
    return BottomNavigationBarItem(
        label: "频道", icon: Icon(Icons.shopping_cart_outlined));
  }

  @override
  State<StatefulWidget> createState() => _ShoppingPageState();

  void onPressed() {}

  @override
  Widget buildAppbarTitle() {
    // TODO: implement buildAppbarTitle
    return Container(
      child: Text(
        "会员购",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("会员购"),
    );
  }
}
