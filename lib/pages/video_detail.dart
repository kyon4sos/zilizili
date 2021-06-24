import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psite/components/follow_button.dart';
import 'package:psite/model/video_model.dart';
import 'package:psite/pages/custom_button.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  String videoUrl =
      "https://1251316161.vod2.myqcloud.com/007a649dvodcq1251316161/c8d47fc05285890807429568876/ZnmAcYfYgV4A.mp4";
  late VideoPlayerController _videoPlayerController =
      VideoPlayerController.network(videoUrl)..initialize().then((_) => {});
  var playTime = "";
  var total = "";
  Map<String, String> user = {
    "avatar":
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201905%2F28%2F20190528143150_fETNW.thumb.700_0.jpeg&refer=http%3A%2F%2Fb-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626866004&t=6cfcacc254385cce5785956397792216"
  };
  List<VideoDetail> recommends = [];
  late StreamController _stream = StreamController();
  var follow = false;
  onPressed(val) {
    print("哈哈$val");
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController.addListener(() {
      var value =
          _videoPlayerController.value.position.toString().substring(0, 7);
      _stream.add(value);
      // _stream.transform(Stream.value(value));
    });
  }

  var toolBar = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          label: "喜欢",
          icon: FaIcon(FontAwesomeIcons.handPointUp),
          onTap: () {
            print("哈哈1");
          },
        ),
        CustomButton(
          label: "不喜欢",
          icon: FaIcon(FontAwesomeIcons.handPointDown),
          onTap: () {
            print("哈哈1");
          },
        ),
        CustomButton(
          label: "投币",
          icon: FaIcon(FontAwesomeIcons.arrowCircleUp),
          onTap: () {
            print("哈哈1");
          },
        ),
        CustomButton(
          label: "收藏",
          icon: FaIcon(FontAwesomeIcons.star),
          onTap: () {
            print("收藏");
          },
        ),
        CustomButton(
          label: "分享",
          icon: FaIcon(FontAwesomeIcons.share),
          onTap: () {
            print("");
          },
        ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = width * 0.66;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 33),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController),
                      )
                    : Container(
                        color: Colors.black,
                        width: width,
                        height: height,
                      ),
              ),
              Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _videoPlayerController.value.isPlaying
                              ? _videoPlayerController.pause()
                              : _videoPlayerController.play();
                        });
                      },
                      icon: Icon(
                        _videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.green,
                      )),
                  SizedBox(
                    width: width * 0.2,
                    child: VideoProgressIndicator(
                      _videoPlayerController,
                      allowScrubbing: true,
                      colors: VideoProgressColors(playedColor: Colors.white),
                    ),
                  ),
                  Container(
                    child: StreamBuilder(
                      stream: _stream.stream,
                      builder:
                          (BuildContext ctx, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Text("00:00:00");
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24.0,
                      foregroundImage: NetworkImage(user["avatar"] ?? ""),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Text(
                            user["username"] ?? "游客",
                            style: TextStyle(color: Colors.pinkAccent),
                          ),
                          Text(user["username"] ?? "0粉丝")
                        ],
                      ),
                    ),
                    FollowButton(onPressed: onPressed, followed: follow),
                    ...Recommend()
                  ],
                ),
              ),
              toolBar
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> Recommend() {
    return [];
  }

  Widget RecommendItem(VideoModel videoModel) {
    return Container(
      child: Row(
        children: [
          Container(
            child: Image.network(videoModel.tags),
          )
        ],
      ),
    );
  }
}

// class FollowButton extends StatelessWidget {
//   const FollowButton({
//     Key? key,
//     required this.onPressed,
//     required this.followed,
//   }) : super(key: key);
//
//   final VoidCallback onPressed;
//   final bool followed;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton.icon(
//       style: ButtonStyle(
//           overlayColor: MaterialStateProperty.all(Colors.grey),
//           foregroundColor: MaterialStateColor.resolveWith((states) {
//             // if (states.contains(MaterialState.pressed)) {
//             //   return Colors.green;
//             // }
//             return Colors.white;
//           }),
//           backgroundColor: MaterialStateColor.resolveWith(
//               (states) => followed ? Colors.grey : Colors.pink)),
//       label: followed ? Text("取消关注") : Text("关注"),
//       icon: followed ? Icon(Icons.clear) : Icon(Icons.add),
//       onPressed: onPressed,
//     );
//   }
// }

// IconButton(
// onPressed: () {
// setState(() {
// _videoPlayerController.value.isPlaying
// ? _videoPlayerController.pause()
//     : _videoPlayerController.play();
// });
// },
// icon: Icon(
// _videoPlayerController.value.isPlaying
// ? Icons.pause
//     : Icons.play_arrow,
// color: Colors.white,
// )),
// VideoProgressIndicator(
// _videoPlayerController,
// allowScrubbing: true,
// colors: VideoProgressColors(playedColor: Colors.white),
// ),
