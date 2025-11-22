import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Container(
        color: Colors.orange[100],
        child: Center(
          child: Text(
            "Welcome to PawPal, $name!",
            style: TextStyle(
              fontSize: 28,
              fontFamily: "Bubblegum Sans",
              fontWeight: FontWeight.bold,
              color: Colors.orange[600],
            ),
          ),
        ),
      ),
    );
  }
}
