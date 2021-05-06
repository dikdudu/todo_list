import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  void changeSelectedTab(BuildContext context, int index) {
    selectedTab = index;
    switch (index) {
      case 0:
        filterFinalyzed();
        break;
      case 1:
        findAllForWeek();
        print(listTodos);
        break;
      case 2:
        break;
    }
    notifyListeners();
  }

  void checkedOrUncheck(TodoModel todo) {
    todo.finished = !todo.finished;
    this.notifyListeners();
    repository.checkOrUncheckTodo(todo);
  }

  void filterFinalyzed() {
    listTodos = listTodos.map((key, value) {
      var todosFinalyzed = value.where((t) => t.finished).toList();
      return MapEntry(key, todosFinalyzed);
    });
    notifyListeners();
  }
}
