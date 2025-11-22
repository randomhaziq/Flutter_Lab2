import 'package:flutter/material.dart';
import 'package:pawpal/pages/home_page.dart';
import 'pages/login_page.dart';

//TODO: delete import below if not used
import 'pages/register_page.dart';

void main() {
  runApp(const PawPal());
}

class PawPal extends StatefulWidget {
  const PawPal({super.key});

  @override
  State<PawPal> createState() => _PawPalState();
}

class _PawPalState extends State<PawPal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[400],
          foregroundColor: Colors.white,
          toolbarTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'Bubblegum Sans',
          ),
          titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Bubblegum Sans',
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: RegisterPage(),
      // home: LoginPage(),
      // home: HomePage(),
    );
  }
}
