import 'package:firebase_example/homepage1.dart';
import 'package:firebase_example/signup.dart';
import 'package:firebase_example/start.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

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
  String? errorMessage;
  bool isPasswordVisible = true;

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
    }
    login();
  }

  login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
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
        appBar: AppBar(
          title: Text(
            "NAB",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
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
                          height: 300,
                          child: Lottie.asset(
                              'assets/images/82915-tree-plantation.json'),
                        ),
                        Container(
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(19),
                                  child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
                                      validator: (input) {
                                        if (input!.isEmpty) {
                                          return 'Enter Email';
                                        }
                                        if (!RegExp(r'\S+@\S+\.\S+')
                                            .hasMatch(input)) {
                                          return 'Please enter a valid email address';
                                        }
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () =>
                                                emailController.clear(),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  30, 25, 20, 15),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: 'Email',
                                          hintText: 'Enter Email',
                                          prefixIcon: const Icon(Icons.email)),
                                      onSaved: (input) => _email = input!),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: TextFormField(
                                      controller: passwordController,
                                      validator: (input) {
                                        if (input!.length < 6) {
                                          return "Provide Minimum 6 Character";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                30, 25, 20, 15),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: 'Password',
                                        hintText: 'Enter your Password',
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          icon: isPasswordVisible
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                          // ? Icon(Icons.visibility_off)
                                          // : Icon(Icons.visibility),
                                          onPressed: () => setState(() =>
                                              isPasswordVisible =
                                                  !isPasswordVisible),
                                        ),
                                      ),
                                      obscureText: isPasswordVisible,
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
