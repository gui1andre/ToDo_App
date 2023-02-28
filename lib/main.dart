import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/provider/todo_list.dart';

import 'src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ToDoApp(
    list: [],
  ));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key, required this.list});
  final List<ToDo> list;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToDoProvider(),
      child: MaterialApp(
          themeMode: ThemeMode.system,
          theme: ThemeData(
            primaryColor: Colors.blue.shade700,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.blue.shade700),
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black)),
            useMaterial3: true,
            textTheme: const TextTheme(
              labelLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              labelSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              displayMedium:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              displaySmall:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          darkTheme: ThemeData(
            primaryColor: Colors.blue.shade700,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.blue.shade700),
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white)),
            useMaterial3: true,
            textTheme: const TextTheme(
              labelLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              labelSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              displayMedium:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              displaySmall:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          initialRoute: '/',
          routes: routes),
    );
  }
}
