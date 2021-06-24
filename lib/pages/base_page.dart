import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psite/pages/channel_page.dart';
import 'package:psite/pages/home_page.dart';
import 'package:psite/pages/shopping_page.dart';
import 'abs_base_page.dart';
import 'follow_page.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _BasePageState extends State<BasePage> {
  var currentBtmNavBarIndex = 0;
  List<AbsBasePage> absBasePages = [];

  List<BottomNavigationBarItem> btmNavBarItems = [];
  var username = "neko";
  var level = "LV5";
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var avatarUrl =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201905%2F28%2F20190528143150_fETNW.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626333588&t=0db88d58f7f086d1fa44116bd1c21e6b";
  double paddingLeft = 20;
  List<NavItem> drawerListItems = [
    NavItem(label: "首页", iconData: FontAwesomeIcons.home),
    NavItem(label: "历史记录", iconData: FontAwesomeIcons.history),
    NavItem(label: "下载管理", iconData: FontAwesomeIcons.file),
    NavItem(label: "我的收藏", iconData: FontAwesomeIcons.star),
    NavItem(label: "稍后再看", iconData: FontAwesomeIcons.playCircle),
    NavItem(label: "个性装扮", iconData: FontAwesomeIcons.tshirt),
    NavItem(label: "发布", iconData: FontAwesomeIcons.upload),
    NavItem(label: "创作中心", iconData: FontAwesomeIcons.lightbulb),
    NavItem(label: "热门活动", iconData: FontAwesomeIcons.flag),
    NavItem(label: "直播中心", iconData: FontAwesomeIcons.tv),
    NavItem(label: "我的课程", iconData: FontAwesomeIcons.book),
    NavItem(label: "邀请好友拿红包", iconData: FontAwesomeIcons.award),
    NavItem(label: "游戏中心", iconData: FontAwesomeIcons.gamepad),
    NavItem(label: "我的订单", iconData: FontAwesomeIcons.firstOrder),
    NavItem(label: "会员购中心", iconData: FontAwesomeIcons.cartArrowDown),
    NavItem(label: "联系客服", iconData: FontAwesomeIcons.commentDots),
  ];
  @override
  void initState() {
    absBasePages = [HomePage(), ChannelPage(), FollowPage(), ShoppingPage()];
    btmNavBarItems = absBasePages.map((e) => e.buildNavBarItem()).toList();
    super.initState();
  }

  buildAppBar(int idx) {
    AppBar appBar = AppBar();
    List<Widget> _actions = [];
    List<Widget> _title = [];
    List<Widget> _leading = [
      Container(
        child: Stack(children: [
          Positioned(
            top: 8,
            left: -10,
            child: IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ),
          Positioned(
              top: 10,
              left: 20,
              child: Container(
                color: Colors.green,
                child: CircleAvatar(
                  radius: 20.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      avatarUrl,
                    ),
                  ),
                ),
              )),
          Positioned(
              top: appBar.toolbarHeight,
              left: 20,
              child: Container(
                child: CircleAvatar(
                  radius: 20.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      avatarUrl,
                    ),
                  ),
                ),
              )),
        ]),
      ),
    ];
    _actions.addAll(absBasePages.map((e) => e.buildAppbarAction()));
    _title.addAll(absBasePages.map((e) => e.buildAppbarTitle()));
    appBar = AppBar(
      // leading: _leading[0],
      title: Text("首页"),
      centerTitle: true,
      actions: [_actions[idx]],
      automaticallyImplyLeading: false,
      // actions: [
      //   Expanded(
      //       child: Container(
      //     color: Colors.amberAccent,
      //     child: Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Container(
      //             color: Colors.green,
      //             child: CircleAvatar(
      //               radius: 20.0,
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(100),
      //                 child: Image.network(
      //                   avatarUrl,
      //                 ),
      //               ),
      //             )),
      //         // Wrap(
      //         //   direction: Axis.horizontal,
      //         //   crossAxisAlignment: WrapCrossAlignment.start,
      //         //   children: [
      //         //     Container(
      //         //       child: IconButton(
      //         //         icon: Icon(Icons.menu),
      //         //         onPressed: () {
      //         //           _scaffoldKey.currentState!.openDrawer();
      //         //         },
      //         //       ),
      //         //     ),
      //         //     Container(
      //         //       color: Colors.green,
      //         //       child: CircleAvatar(
      //         //         radius: 20.0,
      //         //         child: ClipRRect(
      //         //           borderRadius: BorderRadius.circular(100),
      //         //           child: Image.network(
      //         //             avatarUrl,
      //         //           ),
      //         //         ),
      //         //       ),
      //         //     )
      //         //   ],
      //         // ),
      //
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [_actions[idx]],
      //         ),
      //       ],
      //     ),
      //   ))
      // ],
    );
    return appBar;
  }

  buildBody(int idx) {
    return absBasePages[idx];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [drawerHeader(), member(), ...drawerListItems],
          ),
        ),
      ),
      appBar: buildAppBar(currentBtmNavBarIndex),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onBtnNavBarTap,
          currentIndex: currentBtmNavBarIndex,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: TextStyle(color: Colors.green),
          selectedItemColor: Colors.pink,
          items: btmNavBarItems),
      body: buildBody(currentBtmNavBarIndex),
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(color: Colors.pink),
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [userAvatar(), userInfo()]),
        ));
  }

  Widget userAvatar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.white, width: 2)),
      margin: EdgeInsets.only(bottom: 24),
      child: CircleAvatar(
        radius: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            avatarUrl,
            width: 80,
            height: 80,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  Widget userInfo() {
    return Row(
      children: [
        Text(
          username,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          margin: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            level,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: Color(0xFFE3A6BE),
              border: Border.all(width: 1, color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          margin: EdgeInsets.only(right: 6),
          child: Text(
            "正式会员",
            style: TextStyle(color: Colors.pink, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget member() {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "我的大会员",
                  style: TextStyle(color: Colors.pink, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: Text(
                  "了解更多权益",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget _buildListItem(int idx) {
    return drawerListItems[idx];
  }

  void onBtnNavBarTap(int value) {
    currentBtmNavBarIndex = value;
    setState(() {});
  }

  void onPressed() {}

  void onLeadingPressed() {}
}

class NavItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  static const double paddingLeft = 20;
  NavItem({required this.label, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: paddingLeft),
      height: 50,
      child: Row(
        children: [
          IconButton(
              onPressed: iconOnPressed,
              icon: FaIcon(iconData, color: Colors.grey)),
          Container(
            margin: EdgeInsets.only(left: paddingLeft * 2),
            child: Text(
              label,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  void iconOnPressed() {}
}
