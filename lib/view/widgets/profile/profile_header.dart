import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/profile/profile_info.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = Text('Profile',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
        ));
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[title],
          ),
          ProfileInfo()
        ],
      ),
    );
  }
}
