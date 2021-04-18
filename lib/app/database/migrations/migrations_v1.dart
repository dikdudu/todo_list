import 'package:sqflite/sqflite.dart';

void createV1(Batch batch) {
  batch.execute(''' 
    create table todo(
      id Integer primary key autoincrement,
      description varchar(500) not null,
      date_time datetime,
      finished integer
    )
  ''');
}
