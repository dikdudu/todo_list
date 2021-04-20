import 'dart:convert';

class TodoModel {
  int id;
  String description;
  DateTime dateTime;
  bool finished;
  TodoModel({
    this.id,
    this.description,
    this.dateTime,
    this.finished,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'finished': finished,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      description: map['description'],
      dateTime: DateTime.parse(map['date_time']),
      finished: map['finished'] == 0 ? false : true,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));
}
