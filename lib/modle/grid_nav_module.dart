class GridNav {
  Hotel hotel;
  Flight flight;
  Travel travel;

  GridNav({this.hotel, this.flight, this.travel});

  GridNav.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new Hotel.fromJson(json['hotel']) : null;
    flight =
    json['flight'] != null ? new Flight.fromJson(json['flight']) : null;
    travel =
    json['travel'] != null ? new Travel.fromJson(json['travel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel.toJson();
    }
    if (this.flight != null) {
      data['flight'] = this.flight.toJson();
    }
    if (this.travel != null) {
      data['travel'] = this.travel.toJson();
    }
    return data;
  }
}

class Hotel {
  String startColor;
  String endColor;
  MainItem mainItem;
  Item1 item1;
  Item2 item2;
  Item3 item3;
  Item4 item4;

  Hotel(
      {this.startColor,
        this.endColor,
        this.mainItem,
        this.item1,
        this.item2,
        this.item3,
        this.item4});

  Hotel.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new MainItem.fromJson(json['mainItem'])
        : null;
    item1 = json['item1'] != null ? new Item1.fromJson(json['item1']) : null;
    item2 = json['item2'] != null ? new Item2.fromJson(json['item2']) : null;
    item3 = json['item3'] != null ? new Item3.fromJson(json['item3']) : null;
    item4 = json['item4'] != null ? new Item4.fromJson(json['item4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
    if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
    return data;
  }
}

class MainItem {
  String title;
  String icon;
  String url;
  String statusBarColor;

  MainItem({this.title, this.icon, this.url, this.statusBarColor});

  MainItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}

class Item1 {
  String title;
  String url;
  String statusBarColor;

  Item1({this.title, this.url, this.statusBarColor});

  Item1.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}

class Item2 {
  String title;
  String url;

  Item2({this.title, this.url});

  Item2.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class Item3 {
  String title;
  String url;
  bool hideAppBar;

  Item3({this.title, this.url, this.hideAppBar});

  Item3.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}

class Item4 {
  String title;
  String url;
  bool hideAppBar;

  Item4({this.title, this.url, this.hideAppBar});

  Item4.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}

class Flight {
  String startColor;
  String endColor;
  MainItem mainItem;
  Item1 item1;
  Item2 item2;
  Item3 item3;
  Item4 item4;

  Flight(
      {this.startColor,
        this.endColor,
        this.mainItem,
        this.item1,
        this.item2,
        this.item3,
        this.item4});

  Flight.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new MainItem.fromJson(json['mainItem'])
        : null;
    item1 = json['item1'] != null ? new Item1.fromJson(json['item1']) : null;
    item2 = json['item2'] != null ? new Item2.fromJson(json['item2']) : null;
    item3 = json['item3'] != null ? new Item3.fromJson(json['item3']) : null;
    item4 = json['item4'] != null ? new Item4.fromJson(json['item4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
    if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
    return data;
  }
}

class Travel {
  String startColor;
  String endColor;
  MainItem mainItem;
  Item1 item1;
  Item2 item2;
  Item3 item3;
  Item4 item4;

  Travel(
      {this.startColor,
        this.endColor,
        this.mainItem,
        this.item1,
        this.item2,
        this.item3,
        this.item4});

  Travel.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new MainItem.fromJson(json['mainItem'])
        : null;
    item1 = json['item1'] != null ? new Item1.fromJson(json['item1']) : null;
    item2 = json['item2'] != null ? new Item2.fromJson(json['item2']) : null;
    item3 = json['item3'] != null ? new Item3.fromJson(json['item3']) : null;
    item4 = json['item4'] != null ? new Item4.fromJson(json['item4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
    if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
    return data;
  }
}