
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_band/user/login.dart';
import 'package:music_band/user/signUpOrLogin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();

  final _key = GlobalKey<FormState>();

  final _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[500],
        title: Text('Sign Up'),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => SignUpOrLogin())));
              },
              child: Text('Cancel'))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 350,
                      child: TextFormField(
                        validator: (value){
                          if (value.isEmpty) {
                            return 'Name cannot be empty';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 350,
                      child: TextFormField(
                        validator: (value){
                          if (value.isEmpty) {
                            return 'Number cannot be empty';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Number",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 350,
                      child: TextFormField(
                        validator: (value){
                          if (value.isEmpty) {
                            return 'email cannot be empty';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "email",
                          labelStyle: TextStyle(fontSize: 15.0),
                          //hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: 350,
                      child: TextFormField(
                        validator: (value){
                          if (value.isEmpty) {
                            return 'password cannot be empty';
                          } else
                            return null;
                        },
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 15.0),
                          //hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text('Sign Up'),
                        onPressed: () async{
                          if(_key.currentState.validate()){
                            FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                                .then((signedUser){
                                  _firestore.collection('Users').doc(signedUser.user.uid)
                                      .set({
                                    "Name":nameController.text,
                                    "Number":numberController.text,
                                    "Email":emailController.text,
                                    "Password":passwordController.text,
                                    "uid": signedUser.user.uid,
                                  }).then((value){
                                    if(signedUser != null){
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext contxt) {
                                            return AlertDialog(
                                              title: Text("Success"),
                                              content: Text(
                                                  "Signed Up Successfully"),
                                              actions: [
                                                FlatButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: ((context) => Login())));
                                    }
                                  }).catchError((e){
                                    print(e);
                                  });
                            }).catchError((e){
                              print(e);
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


