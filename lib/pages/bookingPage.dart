import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BookingPage extends StatefulWidget {

  final String band;

  const BookingPage( this.band);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  final _key = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _costController = TextEditingController();

  static DateFormat dateFormat = new DateFormat('dd/MM/yyyy');
  String dateTime;

  String username, email, number,uid;

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

  bool isUploading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bookRef = FirebaseFirestore.instance.collection('Booking details');
  String postId = Uuid().v4();

  createBookingInFirestore({
    String name,
    String address,
    String number,
    String date,
    String price,
}){
  bookRef.doc(postId).set({
    "Customer Name": name,
    "Band name": widget.band,
    "Address":address,
    "Number":number,
    "date":date,
    "Price":int.parse(price),
    "uid":uid,
    "postId":postId,
  });
}

  submit() async{
    print(_auth.currentUser.uid);
    setState(() {
      isUploading = true;
    });
    createBookingInFirestore(
      name: _nameController.text,
      date:dateTime,
      address: _addressController.text,
      number: _numberController.text,
      price: _costController.text,
    );
    _nameController.clear();
    _addressController.clear();
    _numberController.clear();
    _costController.clear();
    //dateTime = DateTime.now() as String;
    setState(() {
      isUploading = false;
    });
    return showDialog(
        context: context,
        builder: (BuildContext contxt) {
          return AlertDialog(
            title: Text("Success"),
            content: Text(
                "Booked Successfully"),
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
  }

  @override
  Widget build(BuildContext context) {
    _fetch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text('Band Booking : ${widget.band}',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _key,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Full Name cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Address cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Number cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Contact Number',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20,),
                      DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Start Date',
                        timeLabelText: "Hour",
                        onChanged: (val) {
                          setState(() {
                            dateTime = val;
                            print("Start date:  " + val);
                          });
                        },
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) =>  print(val),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: _costController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Price cannot be empty';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Price (in Rs)',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Book Now'),
                            onPressed: isUploading ? null : () => submit(),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
