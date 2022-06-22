import 'package:flutter/material.dart';

class HomeInfo extends StatelessWidget {
  HomeInfo({Key? key}) : super(key: key);

  final info = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        child: const Text(
          'Go to the ToDo view and add your tasks! 📌',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
      child: Row(
        children: <Widget>[info],
      ),
    );
  }
}
