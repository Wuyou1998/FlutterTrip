import 'package:xiecheng_demo/model/sales_box_module.dart';
import 'package:xiecheng_demo/model/sub_nav_list_module.dart';

import 'banner_list_module.dart';
import 'config_module.dart';
import 'grid_nav_module.dart';
import 'local_nav_list_module.dart';

class HomeModule {
  Config config;
  List<BannerListModule> bannerList;
  List<LocalNavListItem> localNavList;
  GridNav gridNav;
  List<SubNavListItem> subNavList;
  SalesBoxModel salesBoxModel;

  HomeModule(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBoxModel});

  HomeModule.fromJson(Map<String, dynamic> json) {
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['bannerList'] != null) {
      bannerList = new List<BannerListModule>();
      json['bannerList'].forEach((v) {
        bannerList.add(new BannerListModule.fromJson(v));
      });
    }
    if (json['localNavList'] != null) {
      localNavList = new List<LocalNavListItem>();
      json['localNavList'].forEach((v) {
        localNavList.add(new LocalNavListItem.fromJson(v));
      });
    }
    gridNav =
        json['gridNav'] != null ? new GridNav.fromJson(json['gridNav']) : null;
    if (json['subNavList'] != null) {
      subNavList = new List<SubNavListItem>();
      json['subNavList'].forEach((v) {
        subNavList.add(new SubNavListItem.fromJson(v));
      });
    }
    salesBoxModel = json['salesBox'] != null
        ? new SalesBoxModel.fromJson(json['salesBox'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.localNavList != null) {
      data['localNavList'] = this.localNavList.map((v) => v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav.toJson();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList.map((v) => v.toJson()).toList();
    }
    if (this.salesBoxModel != null) {
      data['salesBox'] = this.salesBoxModel.toJson();
    }
    return data;
  }
}
