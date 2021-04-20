import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  String nome = 'Eduardo';

  void alterarNome() {
    nome = 'Eduardo Santos';
    notifyListeners();
  }
}
