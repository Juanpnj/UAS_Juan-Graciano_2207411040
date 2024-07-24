import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter First App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter First App'),
        ),
        body: const Center(
          child: Text('Juan Graciano 2207411040'),
        ),
      ),
    );
  }
}
