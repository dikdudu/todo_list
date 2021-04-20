import 'package:flutter/foundation.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';

class HomeController extends ChangeNotifier {
  final TodosRepository repository;

  HomeController({@required this.repository});
}
