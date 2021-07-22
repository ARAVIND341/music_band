import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_band/pages/bookingPage.dart';
import 'package:date_time_picker/date_time_picker.dart';

class BandPage extends StatefulWidget {
  @override
  _BandPageState createState() => _BandPageState();
}

class _BandPageState extends State<BandPage> {

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
  }



  @override
  Widget build(BuildContext context) {
    _fetch();
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Music Bands'),
        backgroundColor: Colors.yellow[800],
      ),
      backgroundColor: Colors.yellowAccent[50],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text("Click on a band to continue booking",style: TextStyle(color: Colors.yellow[900],fontSize: 20 ,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => BookingPage("Parikrama")));
                    print('clicked');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('images/parikrama.jpg'),
                          fit: BoxFit.cover,
                        )),
                    child: RichText(
                      text: TextSpan(
                        text:"Parikrama",
                        style: TextStyle(
                          fontSize: 35.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[50],
                        ),
                      ),
                    ),
                    width: 350,
                    height: 140,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => BookingPage("Coshish")));
                    print('clicked');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage('images/coshish.jpg'),
                          fit: BoxFit.cover,
                        )),
                    child: RichText(
                      text: TextSpan(
                        text:"Coshish",
                        style: TextStyle(
                          fontSize: 35.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[50],
                        ),
                      ),
                    ),
                    width: 350,
                    height: 140,
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
