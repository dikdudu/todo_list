import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/models/todo_model.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';
import 'package:collection/collection.dart';

class HomeController extends ChangeNotifier {
  final TodosRepository repository;
  int selectedTab = 1;
  DateTime startFilter;
  DateTime endFilter;

  Map<String, List<TodoModel>> listTodos;

  HomeController({@required this.repository}) {
    findAllForWeek();
  }

  void changeSelected(index) {
    selectedTab = index;
    notifyListeners();
  }

  Future<void> findAllForWeek() async {
    var dateFormat = DateFormat('dd/MM/yyyy');

    startFilter = DateTime.now();

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }

    endFilter = startFilter.add(Duration(days: 6));

    var todos = await repository.findByPeriod(startFilter, endFilter);

    if (todos.isEmpty) {
      listTodos = {dateFormat.format(DateTime.now()): []};
    } else {
      listTodos =
          groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dateTime));
    }

    this.notifyListeners();
  }
}
