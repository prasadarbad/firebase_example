import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/HomePage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/homepage1.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email = "",
      _password = "",
      _cellno = "",
      _faxno = "",
      _name = "",
      _telno = "",
      _time = " ";

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
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    insertData();
  }

  insertData() async {
    var db = FirebaseFirestore.instance.collection("contactperson");
    db.add({
      "name": _name,
      "cellNo": _cellno,
      "email": _email,
      "faxNo": _faxno,
      "tellNo": _telno
    });
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Container(
                height: 400,
                child: const Image(
                  image: AssetImage("assets/images/farmer1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Name';
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
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
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Cell no';
                          },
                          decoration: const InputDecoration(
                            labelText: 'Cell no ',
                            prefixIcon: Icon(Icons.phone),
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
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Email';
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
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
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Fax no',
                            prefixIcon: Icon(Icons.phone),
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
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Enter Tel no',
                            prefixIcon: Icon(Icons.phone_android_rounded),
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
                        child: TextFormField(
                          validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minimum 6 Character';
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
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
