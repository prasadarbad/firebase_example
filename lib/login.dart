import 'package:firebase_example/homepage1.dart';
import 'package:firebase_example/signup.dart';
import 'package:firebase_example/start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddData()));
      }
    });
    @override
    void initState() {
      super.initState();
      this.checkAuthentication();
    }
  }

  login1() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      login();
    }
  }

  login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  // Navigator.push(
  //     context, MaterialPageRoute(builder: (context) => const HomePage()));

  showError(String errormessage) {
    return AlertDialog(
      title: Text('Error'),
      content: Text('Error Message'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AddData();
              } else {
                return SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 400,
                          child: Image(
                            image: AssetImage("assets/images/farming.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: TextFormField(
                                      controller: emailController,
                                      validator: (input) {
                                        if (input!.isEmpty) {
                                          return 'Enter Email';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Email',
                                          prefixIcon: Icon(Icons.email)),
                                      onSaved: (input) => _email = input!),
                                ),
                                Container(
                                  child: TextFormField(
                                      controller: passwordController,
                                      validator: (input) {
                                        if (input!.length < 6) {
                                          return "Provide Minimum 6 Character";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: Icon(Icons.lock),
                                      ),
                                      obscureText: true,
                                      onSaved: (input) => _password = input!),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: login1,
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: const Text(
                                      'Dont have an Account? Signup'),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
      );
}
