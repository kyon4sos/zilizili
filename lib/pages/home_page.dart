import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psite/model/video_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psite/api.dart';
import 'package:psite/pages/abs_base_page.dart';

class HomePage extends AbsBasePage {
  @override
  Widget buildAppbarAction() {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Padding(padding: EdgeInsets.only(left: 8.w)),

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

  onPressed() {}

  @override
  State<StatefulWidget> createState() => _HomePageState();

  @override
  Widget buildAppbarTitle() {
    return Text("data");
  }
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
  List<VideoModel> videos = [];
  int videoIndex = 0;
  late TabController _tabController =
      TabController(initialIndex: 1, length: tabs.length, vsync: this);

  static var crossAxisCount = 2;

  late ScrollController _scrollController = ScrollController()
    ..addListener(() {});
  late RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
              height: MediaQuery.of(context).size.height,
              color: Color(0xcdcdcdcd),
              padding: EdgeInsets.only(left: 8.w, top: 8.w),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _liveTabBarView(),
                  _recommendTabBarView(),
                  _hotTabBarView(),
                  _animationTabBarView(),
                  _filmTabBarView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendTabBarView() {
    return SmartRefresher(
      enablePullUp: true,
      enablePullDown: true,
      onLoading: _onLoading,
      onRefresh: _onRefresh,
      controller: _refreshController,
      header: MaterialClassicHeader(),
      footer: ClassicFooter(
        loadingText: "努力加载中！",
        idleText: "上拉加载更多！",
        noDataText: "没有了，别拉了！",
        canLoadingText: "松开加载更多",
      ),
      child: GridView.builder(
          controller: _scrollController,
          itemCount: videos.length,
          gridDelegate: gridDelegate,
          itemBuilder: itemBuilder),
    );
  }

  void _onLoading() async {
    // monitor network fetch
    var res = await Mock().videosFactory(startIndex: videoIndex += 10);
    videos.addAll(res);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    // monitor network fetch
    videos.clear();
    var res = await Mock().videosFactory();
    videos.addAll(res);
    if (mounted) setState(() {});
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Widget _filmTabBarView() {
    return Center(
      child: Text("电影"),
    );
  }

  Widget _hotTabBarView() {
    return Center(
      child: Text("热门"),
    );
  }

  Widget _animationTabBarView() {
    return Center(
      child: Text("动画"),
    );
  }

  Widget _liveTabBarView() {
    return Center(
      child: Text("电影"),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount gridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount);
  Widget itemBuilder(BuildContext context, int index) {
    print(index);
    return videoCard(videos[index]);
  }

  Widget videoCard(VideoModel videoModel) {
    final double width = MediaQuery.of(context).size.width / 2;
    final double height = width * 0.52;
    return GestureDetector(
      onTap: _onTapVideoCard,
      child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
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
      ),
    );
  }

  iconsOnPressed() {}

  void _onTapVideoCard() {
    Navigator.of(context).pushNamed("video-detail");
  }
}
