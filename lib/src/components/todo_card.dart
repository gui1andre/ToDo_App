import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/src/components/categoria_chip.dart';

import 'package:todo_list/src/models/todo.dart';

class ToDoCard extends StatefulWidget {
  ToDoCard({super.key, required this.toDo, this.isExpanded = false});

  final ToDo toDo;
  bool isExpanded;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
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

      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.toDo.titulo!,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: textTheme.displayMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.date_range),
                  Text(
                    formatador.format(DateTime.parse(widget.toDo.data!)),
                    style: textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Prioridade',
                style: textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: widget.toDo.prioridade!,
                      child: Container(
                        decoration: BoxDecoration(
                            color: verificarPrioridade(widget.toDo.prioridade!),
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(16),
                              topLeft: const Radius.circular(16),
                              topRight: Radius.circular(
                                  verificarBarraFinal(widget.toDo.prioridade!)),
                              bottomRight: Radius.circular(
                                  verificarBarraFinal(widget.toDo.prioridade!)),
                            )),
                        height: 8,
                      ),
                    ),
                    Expanded(
                      flex: calcularBarra(widget.toDo.prioridade!),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            bottomRight: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            topLeft: Radius.circular(
                                verificarBarraInicial(widget.toDo.prioridade!)),
                            bottomLeft: Radius.circular(
                                verificarBarraInicial(widget.toDo.prioridade!)),
                          ),
                        ),
                        height: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.toDo.categorias!.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categorias',
                  style: textTheme.displaySmall,
                ),
              ),
            ),
            Visibility(
              visible: widget.toDo.categorias!.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: SizedBox(
                  height: 36,
                  child: ListView.separated(
                    itemCount: widget.toDo.categorias!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const Padding(padding: EdgeInsets.only(right: 8)),
                    itemBuilder: (context, index) {
                      return chipCategoria(widget.toDo.categorias!)[index];
                    },
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.toDo.etapas!.isNotEmpty,
              child: ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 1000),
                children: [
                  ExpansionPanel(
                    body: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.toDo.etapas!.map((e) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: ListTile(
                              title: Text(
                              '${e.id}. ${e.nome!}',
                              style: TextStyle(
                                fontWeight: textTheme.bodySmall!.fontWeight,
                                fontSize: textTheme.bodySmall!.fontSize,
                                decoration: e.concluido! ? TextDecoration.lineThrough : null
                              ),
                            ),
                            trailing: Checkbox(value: e.concluido,
                            onChanged: (value) {
                              setState(() {
                                e.concluido = value;
                              });
                            }),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Etapas',
                            style: textTheme.displaySmall,
                            
                          ),
                        ),
                      );
                    },
                    isExpanded: widget.isExpanded,
                  )
                ],
                expansionCallback: (int item, bool status) {
                  setState(() {
                    widget.isExpanded = !widget.isExpanded;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
