import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/signup.dart';

class AddData extends StatefulWidget {
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  User? user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance.collection("contactperson");

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
        backgroundColor: Colors.green,
        title: Text("NBA"),
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
            }

            if (!snapshot.data!.exists) {
              return Text("empty");
            } else {
              var data1 = snapshot.data!.data() as Map<String, dynamic>;
              return Container(
                child: Center(child: Text((data1)["email"])),
              );
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
