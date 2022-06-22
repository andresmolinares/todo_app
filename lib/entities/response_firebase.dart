import 'package:todo_app/entities/todoitem.dart';

class ResponseFirebase {

  List<ToDoItem>? response = [];

  ResponseFirebase({ this.response });

  ResponseFirebase.fromJson(Map<String, dynamic>? json) {

    if (json != null) {
      json.forEach((key, value) {
        response!.add(ToDoItem.fromJson(value));
      });
    }

  }

}