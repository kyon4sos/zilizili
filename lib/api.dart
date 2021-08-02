import 'dart:math';

import 'package:dio/dio.dart';

import 'model/video_model.dart';

var options = BaseOptions(
  baseUrl: 'http://172.16.82.50:3000',
  connectTimeout: 10000,
  receiveTimeout: 10000,
);

class Mock {
  static List<String> tags = ["已关注", "推荐", "热门", "日常"];
  static int count = 0;
  var dio = Dio(options);

  Future<List<VideoModel>> videosFactory({int startIndex = 1}) async {
    Response res =
        await dio.get("/video", queryParameters: {"page": startIndex});
    List<VideoModel> _res = [];
    print("======" + res.data["data"].runtimeType.toString());
    if (res.data["code"] == 20000) {
      List<dynamic> _list = res.data["data"];
      _list.forEach((ele) {
        print(ele["thumbnail"]);
        var video = VideoModel(
            id: ele["id"],
            title: ele["title"],
            desc: "",
            tags: tags[Random.secure().nextInt(tags.length - 1)],
            url: "",
            poster: ele["thumbnail"]);
        _res.add(video);
      });
    }

    // for (var i = startIndex; i < startIndex + size; i++) {
    //   VideoModel video = VideoModel(
    //       title: "猫和老鼠第$i集",
    //       tags: tags[Random.secure().nextInt(tags.length - 1)],
    //       desc: '关注',
    //       url:
    //           'https://1251316161.vod2.myqcloud.com/007a649dvodcq1251316161/c8d47fc05285890807429568876/ZnmAcYfYgV4A.mp4');
    //   _list.add(video);
    // }
    // count += size;
    // await Future.delayed(Duration(milliseconds: 1000));
    return _res;
  }
}
