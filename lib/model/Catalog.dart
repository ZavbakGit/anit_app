class Catalog {
  String name;
  String guid;
  String type;

  Catalog({this.name, this.guid, this.type});

  Catalog.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    guid = json['guid'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['guid'] = this.guid;
    data['type'] = this.type;
    return data;
  }
}