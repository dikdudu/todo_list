import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';

class NewTaskController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd/MM/yyyy');
  final TodosRepository repository;
  DateTime daySelected;
  TextEditingController nameTaskController = TextEditingController();
  bool saved = false;
  bool loading = false;
  String error;

  String get dayFormated => dateFormat.format(daySelected);

  NewTaskController({@required this.repository, String day}) {
    daySelected = dateFormat.parse(day);
  }

  String validator(value) {
    nameTaskController.text = value;
    if (value.isEmpty) {
      return 'Nome da Tarefa e obrigatório';
    }
    return null;
  }

  Future<void> save() async {
    try {
      if (formKey.currentState.validate()) {
        loading = true;
        saved = false;
        await repository.saveTodo(daySelected, nameTaskController.text);
        saved = true;
        loading = false;
      }
    } catch (e) {
      print(e);

      error = 'Erro ao Salvar Tarefa';
    }
    notifyListeners();
  }
}
