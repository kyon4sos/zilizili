import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psite/mock.dart';
import 'package:psite/pages/abs_base_page.dart';

class HomePage extends AbsBasePage {
  @override
  Widget buildAppbarAction() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(padding: EdgeInsets.only(left: 8.w)),
        SizedBox(
          height: 30,
          width: 120,
          child: TextField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withAlpha(80),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: FaIcon(FontAwesomeIcons.gamepad),
        ),
        IconButton(
          onPressed: onPressed,
          icon: FaIcon(FontAwesomeIcons.folder),
        ),
        IconButton(
            onPressed: onPressed, icon: FaIcon(FontAwesomeIcons.envelope))
      ],
    ));
  }

  @override
  BottomNavigationBarItem buildNavBarItem() {
    return BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页");
  }

  Widget buildBody() {
    return Column(
      children: [
        // TabBar(
        //   tabs: tabs,
        //   controller: ,
        // )
      ],
    );
  }

  onPressed() {}

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Widget> tabs = [
    Text("直播"),
    Text("推荐"),
    Text("热门"),
    Text("追番"),
    Text("影视"),
  ];
  var videos = Mock.videosFactory(2);
  late TabController _tabController =
      TabController(length: tabs.length, vsync: this);

  static var crossAxisCount = 2;

  late ScrollController _scrollController = ScrollController()
    ..addListener(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: tabs,
          labelColor: Colors.pink,
          labelPadding: EdgeInsets.symmetric(vertical: 6.w),
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontSize: 20, color: Colors.pink),
          controller: _tabController,
        ),
        // Swiper(),
        Expanded(
          child: Container(
            color: Color(0xcdcdcdcd),
            padding: EdgeInsets.only(left: 8.w, top: 8.w),
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: videos.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: itemBuilder),
                GridView.builder(
                    itemCount: videos.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: itemBuilder),
                GridView.builder(
                    itemCount: videos.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: itemBuilder),
                GridView.builder(
                    itemCount: videos.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: itemBuilder),
                GridView.builder(
                    itemCount: videos.length,
                    gridDelegate: gridDelegate,
                    itemBuilder: itemBuilder),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount);
  Widget itemBuilder(BuildContext context, int index) {
    print(index);
    return VideoCard(videos[index]);
  }

  Widget VideoCard(VideoModel videoModel) {
    final double width = MediaQuery.of(context).size.width / 2;
    final double height = width * 0.52;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      width: width,
      height: width,
      margin: EdgeInsets.only(right: 8.w, bottom: 8.w),
      child: Column(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
              child: Image.network(
                videoModel.url,
                width: width,
                height: height,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(8.w),
                  child: Text(
                    videoModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87, fontSize: 11.w),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Colors.pinkAccent)),
                        child: Text(
                          videoModel.tags,
                          style: TextStyle(
                              fontSize: 9.w, color: Colors.pinkAccent),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  iconsOnPressed() {}
}

class VideoModel {
  String url;
  String desc;
  String title;
  String tags;
  String videoLength;
  int playedCount = 0;
  VideoModel(
      {required this.title,
      required this.desc,
      required this.tags,
      required this.url,
      this.videoLength = "0",
      this.playedCount = 0});
}
