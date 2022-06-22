import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/background.dart';
import 'package:todo_app/view/widgets/profile/profile_header.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Background(),
        ListView(children: const <Widget>[ProfileHeader()])
      ],
    );
  }
}
