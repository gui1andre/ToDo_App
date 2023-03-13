import 'package:flutter/material.dart';

import 'package:todo_list/src/api/webapi.dart';

import '../components/todo_card.dart';
import '../models/todo.dart';

class ToDoDash extends StatefulWidget {
  const ToDoDash({super.key});

  @override
  State<ToDoDash> createState() => _ToDoDashState();
}

class _ToDoDashState extends State<ToDoDash> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    late final ChamadasApi api = ChamadasApi();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add').then((_) => setState(() {})),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      body: FutureBuilder(
        future: api.getTarefas(),
        builder: (context, AsyncSnapshot<List<ToDo>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
        return const Center(
          child: CircularProgressIndicator(),
        );
        case ConnectionState.done:
          
          return  snapshot.data!.isEmpty ? Center(
                  child: Text(
                    'Sua lista de tarefas esta vazia.',
                    style: textTheme.bodyLarge,
                  ),
                ) : SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      const Padding(padding: EdgeInsets.only(top: 16)),
                  itemBuilder: (context, index) {
                    snapshot.data!.sort((a, b) => a.data!.compareTo(b.data!));
                    return ToDoCard(toDo: snapshot.data![index]);
                  },
                ),
              ),
            );
        default:
       return Center(
                  child: Text(
                    'Sua lista de tarefas esta vazia.',
                    style: textTheme.bodyLarge,
                  ),
                );
      }
        },
      ),
    );
  }
}
