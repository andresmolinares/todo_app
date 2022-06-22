import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/background.dart';
import 'package:todo_app/view/widgets/home/home_header.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Background(),
        ListView(children: const <Widget>[
          HomeHeader(),
        ])
      ],
    );
  }
}
