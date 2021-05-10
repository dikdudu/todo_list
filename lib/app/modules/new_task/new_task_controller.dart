import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';

class NewTaskController extends ChangeNotifier {
  final TodosRepository repository;
  DateTime daySelected;
  final dateFormat = DateFormat('dd/MM/yyyy');
  TextEditingController nameTaskController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String get dayFormated => dateFormat.format(daySelected);

  NewTaskController({@required this.repository, String day}) {
    daySelected = dateFormat.parse(day);
  }

  String validator(value) {
    if (value.isEmpty) {
      return 'Nome da Tarefa e obrigatório';
    }
    return null;
  }

  void save() {
    if (formKey.currentState.validate()) {}
  }
}
