import 'package:damath/damath.dart';
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

  void toggle() => value++;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(onPressed: toggle),
      body: StreamWidget(
        stream: FStream.ofInts(),
        builder: (context, value, child) => Center(
          child: Text(
            '$value',
            style: TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }
}
