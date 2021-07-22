import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {


  String username, email, number, uid;

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        username = ds.data()['Name'];
        email = ds.data()['Email'];
        number = ds.data()['Number'];
        uid = ds.data()['uid'];

        print(username);
        print(email);
        print(number);
        print(uid);
      }).catchError((e) {
        print(e);
      });

    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("Booking details").where(
        'uid', isEqualTo: uid).orderBy("Price").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    _fetch();
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking History'),
      ),
      backgroundColor: Colors.white70,
      body: Container(
        child: FutureBuilder(
          future: _fetch(),
          builder: (_, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(child: CircularProgressIndicator(),);
              //return Text(
                //'Loading... please wait', style: TextStyle(fontSize: 17,),);
            return ListView.builder(
                itemCount: snapshot.data != null ? snapshot.data.length : null,
                itemBuilder: (_, index) {
                  DocumentSnapshot data = snapshot.data != null ? snapshot
                      .data[index] : null;
                  return Expanded(
                    child: Container(
                     // height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.greenAccent),
                      ),
                      child: Card(
                        child: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(

                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Band : ${data['Band name']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        "Date : ${data['date']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      Text(
                                        "Rate : ${data['Price']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
