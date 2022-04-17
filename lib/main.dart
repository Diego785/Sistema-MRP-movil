import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SISTEMA MRP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SYSTEM MRP"),
        ),
        backgroundColor: Colors.white,
        body: const Center(
          child: Text('MAIN PAGE SYSTEM MRP'),
        ),
      ),
    );
  }
}
