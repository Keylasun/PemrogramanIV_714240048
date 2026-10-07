import 'package:flutter/material.dart';

class MyStateful extends StatefulWidget {
  const new({super.key});

  @override
  State<MyStateful> createState() => _MyStatefulState();
}

class _MyStatefulState extends State<MyStateful> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                counter++;
              });
            },
            child: Text('Tambah: $counter'),
          ),
        ),
      ),
    );
  }
}
