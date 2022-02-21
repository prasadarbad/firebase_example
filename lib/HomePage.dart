import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_example/start.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedin = false;
  checkAuthentification() {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  // getUser() async {
  //   User? firebaseUser = _auth.currentUser;
  //   await firebaseUser!.reload();
  //   firebaseUser = _auth.currentUser;

  //   if (firebaseUser != null) {
  //     setState(() {
  //       this.user = firebaseUser!;
  //       this.isloggedin = true;
  //     });
  //   }
  // }

  signOut() {
    _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Start()));
  }

  @override
  void initstate() {
    this.checkAuthentification();
    //  this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: isloggedin
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      child: const Image(
                        image: AssetImage("assets/images/homepage.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Hello you are logged in",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: signOut,
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
