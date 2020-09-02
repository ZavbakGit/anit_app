import 'package:anit_app/model/Catalog.dart';

class Task {
  String guid;
  String number;
  DateTime date;
  Catalog responsible;
  String description;
  Catalog partner;
  Catalog director;

  Task({this.guid, this.number, this.date,
    this.responsible, this.description,this.partner,this.director});

  Task.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    number = json['number'];
    date = DateTime.parse(json['date'] as String);
    responsible = json['responsible'] != null
        ? new Catalog.fromJson(json['responsible'])
        : null;
    partner = json['partner'] != null
        ? new Catalog.fromJson(json['partner'])
        : null;

    director = json['director'] != null
        ? new Catalog.fromJson(json['director'])
        : null;

    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    data['number'] = this.number;
    data['date'] = this.date;
    if (this.responsible != null) {
      data['responsible'] = this.responsible.toJson();
    }

    if (this.partner != null) {
      data['responsible'] = this.partner.toJson();
    }

    if (this.director != null) {
      data['responsible'] = this.director.toJson();
    }

    data['description'] = this.description;
    return data;
  }
}

