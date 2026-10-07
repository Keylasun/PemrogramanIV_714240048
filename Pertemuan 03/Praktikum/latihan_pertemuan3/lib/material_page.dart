import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Porsche Gweh')),
        backgroundColor: Color.fromARGB(250, 193, 54, 54),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text('Home')),
            ListTile(title: Text('Settings'))
          ],
        ),
      ),
      body: Center(
        child: BiggerText(
          teks: 'PORSCHE 911',
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {},
      backgroundColor: Colors.lightBlueAccent,
      shape: CircleBorder(), child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
      ]),
    );
  }
}

class Heading extends StatelessWidget {
  final String text;

  const Heading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class BiggerText extends StatefulWidget {
  final String teks;

  const BiggerText({
    Key? key,
    required this.teks,
  }) : super(key: key);

  @override
  State<BiggerText> createState() => _BiggerTextState();
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.teks,
          style: TextStyle(
            fontSize: _textSize,
          ),
        ),
        ElevatedButton(
          child: const Text("Perbesar"),
          onPressed: () {
            setState(() {
              _textSize = 32.0;
            });
          },
        ),
      ],
    );
  }
}