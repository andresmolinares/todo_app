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

  CustomCard({Key? key, required this.description, required this.isActive})
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
                  }),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.description,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoState extends State<Todo> {

  // Verify

  List<ToDoItem> todos = [];
  FirebaseConnection firebaseConnection = FirebaseConnection(); 
  late ResponseFirebase responseFirebase;

  Future<void> getFirebaseData() async {
    final data = await firebaseConnection.getData('todos');
    final responseFirebase = ResponseFirebase.fromJson(data);
    print(responseFirebase.response![0].description);
    setState(() => todos = responseFirebase.response!);
  }

  //


  final _controller = TextEditingController();
  // final List<Map<String, dynamic>> todos = const [
  //   {
  //     "description": "Make a todo app",
  //     "isActive": true,
  //   },
  //   {
  //     "description": "Read a book",
  //     "isActive": false,
  //   },
  //   {
  //     "description": "Learn Flutter",
  //     "isActive": true,
  //   },
  // ];
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
                      firebaseConnection.instanceFirebase().child("todos/6").set({
                          "_id": "6",
                          "description": _controller.text,
                          "isActive": false
                        }
                      );
                      getFirebaseData();
                      print(_controller.text);
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
                  isActive: todos[index].isActive);
            },
          ),
        )
      ],
    ));
  }
}
