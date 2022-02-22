// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_example/login.dart';

// import 'package:firebase_example/start.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool isloggedin = false;
//   String _email = "",
//       _password = "",
//       _cellno = "",
//       _faxno = "",
//       _name = "",
//       _telno = "",
//       _time = " ",
//       _id = "";

//   checkAuthentification() {
//     _auth.authStateChanges().listen((user) {
//       if (user == null) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Start()));
//       }
//     });
//   }

//   // getUser() async {
//   //   await FirebaseFirestore.instance
//   //       .collection("contactperson")
//   //       .doc()
//   //       .get(); //get the data
//   // }

//   signOut() {
//     _auth.signOut();
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const Login()));
//   }

//   @override
//   void initstate() {
//     super.initState();
//     this.checkAuthentification();
//     //  this.getUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('contactperson')
//                 .snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return ListView(
//                 children: snapshot.data!.docs.map((document) {
//                   return Container(
//                     child: Center(
//                       child: Text(
//                         document[_name],
//                       ),
//                     ),
//                   );
//                 }).toList(),

//                 //  Container(
//                 //     child: isloggedin
//                 //         ? CircularProgressIndicator()
//                 //         : Column(
//                 //             children: <Widget>[
//                 //               Container(
//                 //                 height: 400,
//                 //                 child: const Image(
//                 //                   image: AssetImage("assets/images/homepage.png"),
//                 //                   fit: BoxFit.contain,
//                 //                 ),
//                 //               ),

//                 //               ElevatedButton(
//                 //                 onPressed: signOut,
//                 //                 child: const Text(
//                 //                   'Sign Out',
//                 //                   style: TextStyle(
//                 //                     color: Colors.white,
//                 //                     fontSize: 20.0,
//                 //                     fontWeight: FontWeight.bold,
//                 //                   ),
//                 //                 ),
//                 //               ),
//                 //             ],
//                 //           )
//               );
//             }));
//   }
// }
