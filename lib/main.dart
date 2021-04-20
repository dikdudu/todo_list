import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/database/database_adm_connection.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';
import 'package:todo_list/app/modules/home/home_page.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primaryColor: Color(0XFF9A48D0),
        buttonColor: Color(0XFF9A48D0),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: ChangeNotifierProvider(
        create: (_) => HomeController(),
        child: HomePage(),
      ),
    );
  }
}
