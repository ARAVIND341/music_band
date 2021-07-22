import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_band/user/login.dart';
import 'package:music_band/user/signUpOrLogin.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signOut() async{
    await auth.signOut();
    //Navigator.push(context,MaterialPageRoute(builder: (context) => signUpOrLogin()));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpOrLogin()));
  }

  @override
  Widget build(BuildContext context) {
    _fetch();
    return Scaffold(
      backgroundColor: Colors.yellowAccent[50],
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 20.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.yellow[900])),
              child: FutureBuilder(
                future: _fetch(),
              builder: (_,snapshot){
                  if(snapshot.connectionState != ConnectionState.done)
                    return Center(child: CircularProgressIndicator(),);
                    //return Text('Loading... please wait', style: TextStyle(fontSize: 17,),);
              return Column(
                children: <Widget>[
                  SizedBox(height: 80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Name',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 20,
                      ),
                      Text(username != null ? username : " ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Number',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: 20,
                      ),
                      Text(number != null ? number : " ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              );
                })
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow[800],
                    width: 5.0,
                  ),
                  //borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  // color: Colors.green,
                ),
                child: RaisedButton(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    signOut();
                    //Navigator.of(context).pushReplacement(
                      //  MaterialPageRoute(builder: ((context) => Login())));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
