import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Row(
        children: [
          //left side login form
          Expanded(
            child: Container(
              color: Colors.orange[100],
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 56,
                          fontFamily: "Bubblegum Sans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Please enter your details",
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                      ),
                      SizedBox(height: 40),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.visibility),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),

                      //remember me checkbox
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(value: true, onChanged: (value) {}),
                          Text(
                            "Remember Me",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Handle login action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //right side with image
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "PawPal",
                      style: TextStyle(
                        fontSize: 56,
                        fontFamily: "Bubblegum Sans",
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Image.asset(
                      'assets/images/pawpal_icon.png',
                      width: 350,
                      height: 350,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
