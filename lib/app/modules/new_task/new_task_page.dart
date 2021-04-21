import 'package:flutter/material.dart';

class NewTaskPage extends StatelessWidget {
  static String routerName = 'new';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
    );
  }
}
