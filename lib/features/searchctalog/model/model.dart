import 'package:anit_app/model/Catalog.dart';

class ResponseSearch {
  List<Catalog> elements = List<Catalog>();
  int size;

  ResponseSearch({this.elements, this.size = 0});

  ResponseSearch.fromJson(Map<String, dynamic> json) {
    if (json['elements'] != null) {

      elements = new List<Catalog>();
      json['elements'].forEach((v) {
        elements.add(new Catalog.fromJson(v));
      });
    }

    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.elements != null) {
      data['elements'] = this.elements.map((v) => v.toJson()).toList();
    }

    data['size'] = this.size;
    return data;
  }
}
