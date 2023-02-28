import 'package:flutter/material.dart';
import 'package:todo_list/src/screens/add_todo.dart';

import '../screens/dashboard.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const ToDoDash(),
  '/add': (context) => const AddTodo(),
};
