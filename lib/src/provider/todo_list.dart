import 'package:flutter/widgets.dart';

import '../models/todo.dart';

class ToDoProvider extends ChangeNotifier {
  final List<ToDo> _list = [];
  List<ToDo> get getList {
    _list.sort((a, b) => a.data!.compareTo(b.data!));
    return _list;
  }

  void addToDo(ToDo toDo) {
    _list.add(toDo);
    notifyListeners();
  }

  void removeToDo(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  int count() => _list.length;
}
