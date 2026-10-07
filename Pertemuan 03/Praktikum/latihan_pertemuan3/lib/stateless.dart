import 'package:flutter/material.dart';

class MyStateless extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Hello, World!')),
            ElevatedButton(onPressed: () {}, child: Text('Simpan'))
          ],
        )),
        theme: ThemeData.light(),
      );
  }
}