import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/HomePage.dart';
import 'package:firebase_example/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:string_validator/string_validator.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/homepage1.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? errorMessage;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email = "",
      _password = "",
      _cellno = "",
      _faxno = "",
      _name = "",
      _telno = "";

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddData()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    print("signup method");
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Please fill the form';
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }

    insertData();
  }

  insertData() async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    String? errorMessage;
    User? user = _auth.currentUser;
    var db = FirebaseFirestore.instance.collection("contactperson");
    CollectionReference users =
        FirebaseFirestore.instance.collection('contactperson');
    Future<void> addUser() async {
      try {
        await users.doc(user!.uid).set({
          "name": _name,
          "cellNo": _cellno,
          "email": _email,
          "faxNo": _faxno,
          "tellNo": _telno,
          "uid": user.uid,
          // "time": _time,
        });
      } on FirebaseAuthException catch (error) {
        print(error.code);
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

    await addUser();
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddData()));
  }

  showError(String errormessage) {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('Error Message'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NAB",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Container(
                height: 200,
                child: const Image(
                  image: AssetImage("assets/images/nablogo.jpg"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Enter Name';
                            }
                            if (!RegExp(r'[a-z A-Z]').hasMatch(input)) {
                              return 'Enter valid name';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Name',
                            hintText: 'Enter Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                _name = value;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Enter Cell no';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Cell no ',
                            prefixIcon: Icon(Icons.phone_android_rounded),
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                _cellno = value;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return 'Enter Email';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(input)) {
                              return 'Please enter a valid email address';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                _email = value;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Fax no',
                            prefixIcon: Icon(Icons.print),
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                _faxno = value;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Enter Tel no',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          onChanged: (value) {
                            setState(
                              () {
                                _telno = value;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            setState(
                              () {
                                _password = value;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: signUp,

                        // _auth.createUserWithEmailAndPassword(
                        //     email: _email as String,
                        //     password: _password as String);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const HomePage()));

                        child: const Text(
                          'Sign Up',
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
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: const Text('Already an Account? Sign in'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
