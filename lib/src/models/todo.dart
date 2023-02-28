import 'package:todo_list/src/models/prioridade.dart';

class ToDo {
  final String titulo;
  final DateTime date;
  final Prioridade prioridade;
  final List<String> categorias;

  ToDo(
      {required this.titulo,
      required this.date,
      required this.prioridade,
      required this.categorias});
}
