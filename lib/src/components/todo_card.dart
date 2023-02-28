import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/src/components/categoria_chip.dart';

import 'package:todo_list/src/models/todo.dart';

class ToDoCard extends StatelessWidget {
  ToDoCard({super.key, required this.toDo});

  final ToDo toDo;
  final formatador =
      DateFormat("'Dia' dd 'de' MMMM 'de' y 'às' HH:mm 'hrs'", 'pt_BR');

  int calcularBarra(int initial) {
    return 10 - initial;
  }

  List<ChipCategoria> chipCategoria(List<String> lista) {
    List<ChipCategoria> finalList = [];
    for (var element in lista) {
      finalList.add(ChipCategoria(titulo: element));
    }
    return finalList;
  }

  double verificarBarraFinal(int value) {
    if (value == 10) {
      return 16;
    }
    return 0;
  }

  double verificarBarraInicial(int value) {
    if (value == 0) {
      return 16;
    }
    return 0;
  }

  Color verificarPrioridade(int prioridade) {
    if (prioridade <= 4) {
      return Colors.green;
    } else if (prioridade >= 5 && prioridade <= 7) {
      return Colors.orange;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: size.width,
      height: 200,
      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                toDo.titulo,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: textTheme.displayMedium,
              ),
              Row(
                children: [
                  const Icon(Icons.date_range),
                  Text(
                    formatador.format(toDo.date),
                    style: textTheme.displaySmall,
                  ),
                ],
              ),
              Text(
                'Prioridade',
                style: textTheme.displaySmall,
              ),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: toDo.prioridade.prioridade,
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                verificarPrioridade(toDo.prioridade.prioridade),
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(16),
                              topLeft: const Radius.circular(16),
                              topRight: Radius.circular(verificarBarraFinal(
                                  toDo.prioridade.prioridade)),
                              bottomRight: Radius.circular(verificarBarraFinal(
                                  toDo.prioridade.prioridade)),
                            )),
                        height: 8,
                      ),
                    ),
                    Expanded(
                      flex: calcularBarra(toDo.prioridade.prioridade),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            bottomRight: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            topLeft: Radius.circular(verificarBarraInicial(
                                toDo.prioridade.prioridade)),
                            bottomLeft: Radius.circular(verificarBarraInicial(
                                toDo.prioridade.prioridade)),
                          ),
                        ),
                        height: 8,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Categorias',
                style: textTheme.displaySmall,
              ),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  itemCount: toDo.categorias.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const Padding(padding: EdgeInsets.only(right: 8)),
                  itemBuilder: (context, index) {
                    return chipCategoria(toDo.categorias)[index];
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
