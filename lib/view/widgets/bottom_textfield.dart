import 'package:flutter/material.dart';

class BottomTextField extends StatefulWidget {
  const BottomTextField({Key? key}) : super(key: key);

  @override
  State<BottomTextField> createState() => _BottomTextFieldState();
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
          color: Color.fromARGB(193, 224, 227, 230),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: SizedBox(
            width: 370,
            height: 120,
            child: Center(child: Text('Clean Card')),
          )),
    );
  }
}

class _BottomTextFieldState extends State<BottomTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      hintText: 'Make the dinner',
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
                      print(_controller.text);
                    },
                    child: const Icon(Icons.add))
              ],
            )),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return const CustomCard();
            },
          ),
        )
      ],
    ));
  }
}
