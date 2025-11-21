import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Page")),
      body: Row(
        children: [
          //left side image
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.orange[100],
              child: Center(
                child: Image.asset(
                  'assets/images/register_image.png',
                  width: 500,
                  height: 500,
                ),
              ),
            ),
          ),

          //right side register form
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Register Here!",
                      style: TextStyle(
                        fontSize: 56,
                        fontFamily: "Bubblegum Sans",
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Full Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email Address',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility_off),
                        labelText: 'Create Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility_off),
                        labelText: 'Confirm Password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'Phone Number',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Handle login action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // TODO: Handle register navigation
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Login here.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue[900],
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
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
