import 'package:anit_app/model/Catalog.dart';

class UserSetting{
  Catalog user;
  List<Catalog> listGroupTask;

  UserSetting.fromJson(Map<String, dynamic> json) {
    if (json['listGroupTask'] != null) {
      listGroupTask = new List<Catalog>();
      json['listGroupTask'].forEach((v) {
        listGroupTask.add(new Catalog.fromJson(v));
      });
    }

    user = json['director'] != null
        ? new Catalog.fromJson(json['director'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listGroupTask != null) {
      data['tasks'] = this.listGroupTask.map((v) => v.toJson()).toList();
    }

    if (this.user != null) {
      data['user'] = this.user.toJson();
    }

    return data;
  }
}