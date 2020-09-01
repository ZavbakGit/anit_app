class TaskItem {
  String guid;
  String number;
  DateTime date;
  String importance;
  String description;
  String responsible;
  String partner;

  TaskItem(
      {this.guid,
        this.number,
        this.date,
        this.importance,
        this.description,
        this.responsible,
        this.partner});

  TaskItem.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    number = json['number'];
    date = DateTime.parse(json['date'] as String);
    importance = json['importance'];
    description = json['description'];
    responsible = json['responsible'];
    partner = json['partner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guid'] = this.guid;
    data['number'] = this.number;
    data['date'] = this.date;
    data['importance'] = this.importance;
    data['description'] = this.description;
    data['responsible'] = this.responsible;
    data['partner'] = this.partner;
    return data;
  }
}