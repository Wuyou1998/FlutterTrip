class SubNavListItem {
  String icon;
  String title;
  String url;
  bool hideAppBar;

  SubNavListItem({this.icon, this.title, this.url, this.hideAppBar});

  SubNavListItem.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}
