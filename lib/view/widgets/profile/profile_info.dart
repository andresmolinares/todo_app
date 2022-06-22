import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  ProfileInfo({Key? key}) : super(key: key);
  final userPhoto = Container(
      width: 90.0,
      height: 90.0,
      margin: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white, width: 2.0, style: BorderStyle.solid),
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network('https://picsum.photos/200/300').image)));

  final userInfo =
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: const Text(
        'Sample Text',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    const Text(
      'example@email.com',
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.white30,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
      child: Row(
        children: <Widget>[userPhoto, userInfo],
      ),
    );
  }
}
