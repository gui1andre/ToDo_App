import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/src/provider/todo_list.dart';

import '../components/todo_card.dart';

class ToDoDash extends StatelessWidget {
  const ToDoDash({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add'),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: Consumer<ToDoProvider>(
        builder: (context, value, child) {
          return value.count() == 0
              ? Center(
                  child: Text(
                    'Sua lista de tarefas esta vazia.',
                    style: textTheme.bodyLarge,
                  ),
                )
              : SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: ListView.separated(
                      itemCount: value.count(),
                      separatorBuilder: (context, index) =>
                          const Padding(padding: EdgeInsets.only(top: 16)),
                      itemBuilder: (context, index) {
                        return ToDoCard(toDo: value.getList[index]);
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
