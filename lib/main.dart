import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/database/database_adm_connection.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/home_page.dart';
import 'package:todo_list/app/modules/new_task/new_task_controller.dart';
import 'package:todo_list/app/modules/new_task/new_task_page.dart';
import 'package:todo_list/app/repositories/todos_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DataBaseAdmConnection dataBaseAdmConnection = DataBaseAdmConnection();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(dataBaseAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(dataBaseAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => TodosRepository(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          primaryColor: Color(0XFF18DCC2),
          buttonColor: Color(0XFF9A48D0),
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        routes: {
          NewTaskPage.routerName: (_) => ChangeNotifierProvider(
                create: (context) {
                  String day = ModalRoute.of(_).settings.arguments;
                  return NewTaskController(
                    repository: context.read<TodosRepository>(),
                    day: day,
                  );
                },
                child: NewTaskPage(),
              ),
        },
        home: ChangeNotifierProvider(
          create: (context) => HomeController(
            repository: context.read<TodosRepository>(),
          ),
          child: HomePage(),
        ),
      ),
    );
  }
}
