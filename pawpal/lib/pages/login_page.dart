import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
  bool isRemember = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Row(
        children: [
          //left side login form
          Expanded(
            child: Container(
              color: Colors.white,
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
                          color: Colors.orange[400],
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
                          suffixIcon: IconButton(
                            icon: Icon(
                              isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                        obscureText: isVisible ? false : true,
                      ),

                      //remember me checkbox
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isRemember,
                            onChanged: (value) {
                              isRemember = value!;
                              setState(() {});
                            },
                          ),
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
                          loginUser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[400],
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),

                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Register here.",
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
          ),

          //right side with image
          Expanded(
            child: Container(
              color: Colors.orange[100],
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

  void loginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isRemember) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        await prefs.setString('email', emailController.text);
        await prefs.setString('password', passwordController.text);
        await prefs.setBool('rememberMe', isRemember);

        SnackBar snackBar = SnackBar(
          content: Text('Preferences Saved Successfully'),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        SnackBar snackBar = SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('rememberMe');

      SnackBar snackBar = SnackBar(
        content: Text('Preferences Removed'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      emailController.clear();
      passwordController.clear();

      setState(() {});
    }
  }

  void loadPreferences() {
    SharedPreferences.getInstance().then((prefs) {
      bool? rememberMe = prefs.getBool('rememberMe');

      if (rememberMe != null && rememberMe) {
        String? email = prefs.getString('email');
        String? password = prefs.getString('password');
        isRemember = true;
        emailController.text = email ?? '';
        passwordController.text = password ?? '';
      } else {
        isRemember = false;
      }

      setState(() {});
    });
  }
}
