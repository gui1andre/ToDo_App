
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../models/todo.dart';
import 'http_interceptor.dart';

class ChamadasApi {
  final String apiLink = 'http://localhost:3000/checklists';
  final Client client = InterceptedClient.build(
    requestTimeout: const Duration(seconds: 20),
    interceptors: [LoggingInterceptor()],
  );

  Future<List<ToDo>> getTarefas() async {

    final url = Uri.parse(apiLink);
    try {
      
    final response = await client.get(
      url,
      headers: {
        'Content-type': 'application/json',
      },

    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      List<ToDo> data = [];
      for(int i = 0; i < json.length; i++){
      ToDo todo = ToDo.fromJson(json[i]);
      data.add(todo);}
      return data;
    } 
    } catch (e) {
      throw Exception(e);
      
    }
    return [];
  }
}