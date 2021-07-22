import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_band/pages/home.dart';
import 'package:music_band/user/signUpOrLogin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isVisible = true;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  void signIn() {
    auth
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => Home())));
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      form.save();
      return true;
    } else {
      print('Form is invalid');
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Login'),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => SignUpOrLogin())));
              },
              child: Text('Cancel')),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Center(
                child: Text('Music Band',
                  style: TextStyle(
                    fontSize:40,
                    color:Colors.brown[700],
                    fontWeight: FontWeight.bold,
                  ) ,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 100,),
                    Container(
                      width: 350,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email Address",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: 350,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          suffix: GestureDetector (
                            child: Text(isVisible ? 'Show' : 'Hide'),
                            onTap: (){
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: "Must be at least 3 characters",
                          //suffix: Text()
                        ),
                      ),
                    ),
                    SizedBox(height: 80,),
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.brown[400],
                        onPressed: (){
                          signIn();
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
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
