class SalesBox {
  String icon;
  String moreUrl;
  BigCard1 bigCard1;
  BigCard2 bigCard2;
  SmallCard1 smallCard1;
  SmallCard2 smallCard2;
  SmallCard3 smallCard3;
  SmallCard4 smallCard4;

  SalesBox(
      {this.icon,
        this.moreUrl,
        this.bigCard1,
        this.bigCard2,
        this.smallCard1,
        this.smallCard2,
        this.smallCard3,
        this.smallCard4});

  SalesBox.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    moreUrl = json['moreUrl'];
    bigCard1 = json['bigCard1'] != null
        ? new BigCard1.fromJson(json['bigCard1'])
        : null;
    bigCard2 = json['bigCard2'] != null
        ? new BigCard2.fromJson(json['bigCard2'])
        : null;
    smallCard1 = json['smallCard1'] != null
        ? new SmallCard1.fromJson(json['smallCard1'])
        : null;
    smallCard2 = json['smallCard2'] != null
        ? new SmallCard2.fromJson(json['smallCard2'])
        : null;
    smallCard3 = json['smallCard3'] != null
        ? new SmallCard3.fromJson(json['smallCard3'])
        : null;
    smallCard4 = json['smallCard4'] != null
        ? new SmallCard4.fromJson(json['smallCard4'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['moreUrl'] = this.moreUrl;
    if (this.bigCard1 != null) {
      data['bigCard1'] = this.bigCard1.toJson();
    }
    if (this.bigCard2 != null) {
      data['bigCard2'] = this.bigCard2.toJson();
    }
    if (this.smallCard1 != null) {
      data['smallCard1'] = this.smallCard1.toJson();
    }
    if (this.smallCard2 != null) {
      data['smallCard2'] = this.smallCard2.toJson();
    }
    if (this.smallCard3 != null) {
      data['smallCard3'] = this.smallCard3.toJson();
    }
    if (this.smallCard4 != null) {
      data['smallCard4'] = this.smallCard4.toJson();
    }
    return data;
  }
}

class BigCard1 {
  String icon;
  String url;
  String title;

  BigCard1({this.icon, this.url, this.title});

  BigCard1.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}

class BigCard2 {
  String icon;
  String url;
  String title;

  BigCard2({this.icon, this.url, this.title});

  BigCard2.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}

class SmallCard1 {
  String icon;
  String url;
  String title;

  SmallCard1({this.icon, this.url, this.title});

  SmallCard1.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}

class SmallCard2 {
  String icon;
  String url;
  String title;

  SmallCard2({this.icon, this.url, this.title});

  SmallCard2.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}

class SmallCard3 {
  String icon;
  String url;
  String title;

  SmallCard3({this.icon, this.url, this.title});

  SmallCard3.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}

class SmallCard4 {
  String icon;
  String url;
  String title;

  SmallCard4({this.icon, this.url, this.title});

  SmallCard4.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}