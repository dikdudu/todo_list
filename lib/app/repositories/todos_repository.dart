import 'package:todo_list/app/database/connection.dart';
import 'package:todo_list/app/models/todo_model.dart';

class TodosRepository {
  Future<List<TodoModel>> findByPeriod(DateTime start, DateTime end) async {
    var startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    var endFilter = DateTime(end.year, end.month, end.day, 0, 0, 0);

    var conn = await Connection().instance;
    var result = await conn.rawQuery(
      "select * from todo where date_time between ? and ? order by date_time",
      [startFilter.toIso8601String(), endFilter.toIso8601String()],
    );
    return result.map((t) => TodoModel.fromMap(t)).toList();
  }

  Future<void> saveTodo(DateTime dateTimeTask, String description) async {
    var conn = await Connection().instance;

    await conn.rawInsert(
      "insert into todo values(?,?,?,?)",
      [null, description, dateTimeTask.toIso8601String(), 0],
    );
  }

  Future<void> checkOrUncheckTodo(TodoModel todo) async {
    var conn = await Connection().instance;

    await conn.rawUpdate(
      "update todo set finished = ? where id = ?",
      [todo.finished ? 1 : 0, todo.id],
    );
  }
}
