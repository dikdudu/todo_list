import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/new_task/new_task_controller.dart';
import 'package:todo_list/app/shared/time_component.dart';

class NewTaskPage extends StatelessWidget {
  static String routerName = 'new';

  const NewTaskPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskController>(builder:
        (BuildContext context, NewTaskController controller, Widget _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOVA TASK',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Data',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.dayFormated,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Nome da Task',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) => controller.validator(value),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Hora',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TimeComponent(),
                  SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        BoxShadow(
                            // blurRadius: 30,
                            // color: Theme.of(context).primaryColor,
                            ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => controller.save(),
                      child: Center(
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
