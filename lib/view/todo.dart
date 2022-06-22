import 'package:flutter/material.dart';
import '../entities/todoitem.dart';
import '../entities/response_firebase.dart';
import '../domain/firebase_connection.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class CustomCard extends StatefulWidget {
  final String description;
  bool isActive;
  final Function updateState;
  final Function deleteItem;

  CustomCard({
    Key? key, 
    required this.description, 
    required this.isActive, 
    required this.updateState,
    required this.deleteItem
  })
      : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: SizedBox(
          width: 370,
          height: 120,
          child: Row(
            children: <Widget>[
              Checkbox(
                  activeColor: const Color(0xFF460505),
                  value: widget.isActive,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.isActive = value!;
                    });
                    widget.updateState();
                  }),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.description,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold,
                              decoration: widget.isActive 
                                ? TextDecoration.lineThrough
                                : TextDecoration.none
                          )
                      )
                    ]),
              ),
              IconButton(
                icon: Icon(Icons.clear, color: Color(0xFF460505)),
                tooltip: 'Delete item',
                onPressed: () {
                  widget.deleteItem();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoState extends State<Todo> {

  List<ToDoItem> todos = [];
  FirebaseConnection firebaseConnection = FirebaseConnection(); 
  late ResponseFirebase responseFirebase;

  Future<void> getFirebaseData() async {
    final data = await firebaseConnection.getData('todos');
    final responseFirebase = ResponseFirebase.fromJson(data);
    setState(() => todos = responseFirebase.response!);
  }

  void updateState(toDoItem) {
    firebaseConnection.instanceFirebase().child('todos/${toDoItem.id}').update({
      "isActive": (toDoItem.isActive) ? false : true,
    });
    getFirebaseData();
  }

  void deleteItem(toDoItem) {
    firebaseConnection.instanceFirebase().child('todos/${toDoItem.id}').remove();
    getFirebaseData();
  }

  final _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (todos.isEmpty) {
      getFirebaseData();
    }

    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Start typing...',
                      contentPadding: const EdgeInsets.all(15),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide(
                          color: Color(0xFF460505),
                        ),
                      ),
                      prefixIcon:
                          const Icon(Icons.note, color: Color(0xFF460505)),
                      suffixIcon: IconButton(
                        onPressed: _controller.clear,
                        icon: const Icon(Icons.clear, color: Color(0xFF460505)),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton.small(
                    backgroundColor: const Color(0xFF460505),
                    onPressed: () {
                      // TODO: create automated integer ids
                      firebaseConnection.instanceFirebase().child("todos/6").set({
                          "id": "6",
                          "description": _controller.text,
                          "isActive": false
                        }
                      );
                      getFirebaseData();
                    },
                    child: const Icon(Icons.add))
              ],
            )),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return CustomCard(
                  description: todos[index].description,
                  isActive: todos[index].isActive,
                  updateState: () => updateState(todos[index]),
                  deleteItem: () => deleteItem(todos[index]),
              );
            },
          ),
        )
      ],
    ));
  }
}
