import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/components/message_dialog.dart';
import 'package:todo_list/src/models/prioridade.dart';
import 'package:todo_list/src/models/todo.dart';
import 'package:todo_list/src/provider/todo_list.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime eventDate = DateTime.now();
  TimeOfDay hrsEvent = TimeOfDay.now();
  final TextEditingController titulo = TextEditingController();
  final TextEditingController dateText = TextEditingController();
  final TextEditingController hrsText = TextEditingController();
  final TextEditingController categoria = TextEditingController();
  List<String> categorias = [];
  final dateFormat = DateFormat("dd/MM/yyyy");
  double _valorPrioridade = 1;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar To Do'),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatorio';
                      }
                      return null;
                    },
                    controller: titulo,
                    decoration: InputDecoration(
                        label: Text(
                      'Informe o nome da tarefa',
                      style: textTheme.labelSmall,
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 175,
                          child: TextFormField(
                            controller: dateText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              } else {
                                return null;
                              }
                            },
                            readOnly: true,
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              );
                              if (date != null) {
                                eventDate = date;
                                dateText.text = dateFormat.format(date);
                              }
                            },
                            decoration: InputDecoration(
                              label: Text(
                                'Data do Evento',
                                style: textTheme.labelSmall,
                              ),
                              suffixIcon: Icon(
                                Icons.date_range,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 175,
                          child: TextFormField(
                            controller: hrsText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              } else {
                                return null;
                              }
                            },
                            readOnly: true,
                            onTap: () {
                              showTimePicker(
                                      context: context, initialTime: hrsEvent)
                                  .then((value) {
                                if (value != null) {
                                  hrsEvent = value;
                                  hrsText.text = value.format(context);
                                }
                              });
                            },
                            decoration: InputDecoration(
                              label: Text(
                                'Horario do Evento',
                                style: textTheme.labelSmall,
                              ),
                              suffixIcon: Icon(
                                Icons.timer_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
                    child: Text(
                      'Defina a prioridade',
                      style: textTheme.labelSmall,
                    ),
                  ),
                  Slider(
                    value: _valorPrioridade,
                    thumbColor: verificarPrioridade(_valorPrioridade.round()),
                    activeColor: verificarPrioridade(_valorPrioridade.round()),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _valorPrioridade.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _valorPrioridade = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
                    child: TextFormField(
                      controller: categoria,
                      maxLength: 15,
                      decoration: InputDecoration(
                          label: Text(
                            'Categorias',
                            style: textTheme.labelSmall,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (categoria.text.isNotEmpty) {
                                setState(() {
                                  categorias.add(categoria.text);
                                  categoria.text = '';
                                });
                              }
                            },
                            icon: const Icon(Icons.add),
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Wrap(
                      children: categorias.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            label: Text(
                              e,
                              style: textTheme.bodyMedium,
                            ),
                            onDeleted: () {
                              setState(() {
                                categorias.remove(e);
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Consumer<ToDoProvider>(builder: (context, toDo, _) {
                    return Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              final finalDate = DateTime(
                                  eventDate.year,
                                  eventDate.month,
                                  eventDate.day,
                                  hrsEvent.hour,
                                  hrsEvent.minute);

                              if (_formKey.currentState!.validate()) {
                                toDo.addToDo(ToDo(
                                    titulo: titulo.text,
                                    date: finalDate,
                                    prioridade:
                                        Prioridade(_valorPrioridade.round()),
                                    categorias: categorias));
                                showMessageDialog(
                                    context, 'Tarefa incluida com sucesso',
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/',
                                                  (route) => false),
                                          child: const Text('Ok'))
                                    ]);
                              }
                            },
                            child: Text(
                              'Adicionar tarefa',
                              style: textTheme.labelLarge,
                            )),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
