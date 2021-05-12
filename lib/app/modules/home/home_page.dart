import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/new_task/new_task_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext contextConsumer, HomeController controller, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Tarefa',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          bottomNavigationBar: FFNavigationBar(
            selectedIndex: controller.selectedTab,
            onSelectTab: (index) =>
                controller.changeSelectedTab(context, index),
            items: [
              FFNavigationBarItem(
                iconData: Icons.check_circle,
                label: 'Finalizados',
              ),
              FFNavigationBarItem(
                iconData: Icons.view_week,
                label: 'Semanal',
              ),
              FFNavigationBarItem(
                iconData: Icons.calendar_today,
                label: 'Selecionar Data',
              )
            ],
            theme: FFNavigationBarTheme(
              itemWidth: 60,
              barHeight: 70,
              barBackgroundColor: Theme.of(context).primaryColor,
              unselectedItemIconColor: Colors.white,
              unselectedItemLabelColor: Colors.white,
              selectedItemBorderColor: Colors.white,
              selectedItemIconColor: Colors.white,
              selectedItemBackgroundColor: Theme.of(context).primaryColor,
              selectedItemLabelColor: Colors.black,
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              onRefresh: () =>
                  Future.delayed(Duration.zero, () => controller.update()),
              child: ListView.builder(
                itemCount: controller.listTodos?.keys?.length ?? 0,
                itemBuilder: (_, index) {
                  var dateFormat = DateFormat('dd/MM/yyyy');
                  var listTodos = controller.listTodos;
                  var dayKey = listTodos.keys.elementAt(index);
                  var day = dayKey;
                  var todos = listTodos[dayKey];
                  if (todos.isEmpty && controller.selectedTab == 0) {
                    return SizedBox.shrink();
                  }

                  var today = DateTime.now();

                  if (dayKey == dateFormat.format(today)) {
                    day = 'Hoje';
                  } else if (dayKey ==
                      dateFormat.format(today.add(Duration(days: 1)))) {
                    day = 'Amanhã';
                  }

                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                              onPressed: () async {
                                await Navigator.of(context).pushNamed(
                                    NewTaskPage.routerName,
                                    arguments: dayKey);
                                controller.update();
                              },
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: todos.length,
                        itemBuilder: (_, index) {
                          var todo = todos[index];
                          return Dismissible(
                            key: Key(todo.id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) => controller.deleteTodo(todo),
                            confirmDismiss: (_) =>
                                _buildConfirmDismiss(context),
                            background: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                value: todo.finished,
                                onChanged: (bool value) =>
                                    controller.checkedOrUncheck(todo),
                              ),
                              title: Text(
                                todo.description,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  decoration: todo.finished
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              trailing: Text(
                                '${todo.dateTime.hour.toString().padLeft(2, '0')} : ${todo.dateTime.minute.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _buildConfirmDismiss(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Excluir'),
          content: const Text('Confirma a Exlusão da Tarefa?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Confirmar',
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
