import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: fetch the user's name from the user database
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
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
