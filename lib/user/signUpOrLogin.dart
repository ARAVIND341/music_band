import 'package:flutter/material.dart';
import 'package:music_band/user/signUp.dart';
import 'package:music_band/user/login.dart';
import 'package:flutter/cupertino.dart';

class SignUpOrLogin extends StatefulWidget {
  @override
  _SignUpOrLoginState createState() => _SignUpOrLoginState();
}

class _SignUpOrLoginState extends State<SignUpOrLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SignUp/Login'),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                print('clicked');
              },
              child: Text('Cancel'))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                //decoration: BoxDecoration(
                  //  image: DecorationImage(
                      //image: AssetImage(Palette.pic4),
                  //    fit: BoxFit.cover,
                  //  )),
                child: Container(
                  padding: EdgeInsets.only(top: 160, left: 15),
                  color: Colors.green.withOpacity(.24),
                  child: RichText(
                    text: TextSpan(
                      text: "Music",
                      style: TextStyle(
                        fontSize: 35.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                      children: [
                        TextSpan(
                          text: "  Band",
                          style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
            top: 280,
            child: Container(
              height: 380,
              padding: EdgeInsets.all(30),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    )
                  ]),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green[700],
                          width: 5.0,
                        ),
                        //borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        // color: Colors.green,
                      ),
                      child: RaisedButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      height: 60,
                      width: 400,
                      decoration: BoxDecoration(

                        border: Border.all(
                          color: Colors.green[700],
                          width: 5.0,
                        ),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: RaisedButton(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: ((context) => Login())));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
