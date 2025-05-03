// ignore_for_file: unused_import
import 'package:dastore/dastore.dart';
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

  @override
  void initState() {
    super.initState();
  }

  void toggle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: 100,
        width: 100,
        color: Colors.brown,
      ),
      floatingActionButton: FloatingActionButton(onPressed: toggle),
    );
  }
}
