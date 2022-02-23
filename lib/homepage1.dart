import 'package:firebase_example/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddData extends StatefulWidget {
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance.collection("contactperson");

  signOut() {
    _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("contactperson").doc(user!.uid).get();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NAB"),
        actions: <Widget>[
          TextButton(
            onPressed: signOut,
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.black.withOpacity(0.8)),
            ),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('contactperson')
              .doc(user!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data1 = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(
                      child: Text((data1)["email"]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(
                      child: Text((data1)["name"]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(
                      child: Text((data1)["cellNo"]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(
                      child: Text((data1)["faxNo"]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: Center(
                      child: Text((data1)["tellNo"]),
                    ),
                  ),
                ],
              );
              // Container(
              //   child: Center(
              //     child: Text((data1)["email"]),
              //   ),
              // );
            }
          }
          // StreamBuilder(
          //   stream:
          //       FirebaseFirestore.instance.collection('contactperson').snapshots(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }

          //     return ListView(
          //       children: snapshot.data!.docs.map((user!.uid) {
          //         return Container(
          //           child: Center(child: Text(user!.id['email'])),
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),

          ),
    );
  }
}
