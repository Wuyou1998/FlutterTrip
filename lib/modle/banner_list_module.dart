class BannerList {
  String icon;
  String url;

  BannerList({this.icon, this.url});

  BannerList.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
  }

}