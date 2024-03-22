import 'dart:async';

// import 'package:dastore/dastore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int value = 0;

  late final StreamController<int> controller;

  @override
  void initState() {
    controller = StreamController();
    controller.add(0);
    super.initState();
  }

  void toggle() => controller.add(++value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(onPressed: toggle),
      body: Container(
        height: 100,
        width: 100,
        color: Colors.brown,
      ),
    );
  }
}
