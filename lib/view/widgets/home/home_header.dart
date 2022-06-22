import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/home/home_info.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = Text('Welcome to \nToDo App 📝',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 55.0,
        ));
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[title],
          ),
          HomeInfo(),
        ],
      ),
    );
  }
}
