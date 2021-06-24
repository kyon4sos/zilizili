class VideoModel {
  String url;
  String desc;
  String title;
  String tags;
  String videoLength;
  String id;
  String poster;
  int playedCount = 0;
  VideoModel(
      {required this.id,
      required this.poster,
      required this.title,
      required this.desc,
      required this.tags,
      required this.url,
      this.videoLength = "0",
      this.playedCount = 0});
}
