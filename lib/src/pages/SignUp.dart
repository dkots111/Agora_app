import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatelessWidget{

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Text('Create Account,',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold, fontFamily: 'Dosis'),),
                  SizedBox(height: 6,),
                  Text('Sign up to get started!',style: TextStyle(fontSize: 16,color: Colors.grey.shade400, fontFamily: 'Dosis'),),
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontSize: 10,color: Colors.grey.shade400,fontWeight: FontWeight.w600, fontFamily: 'Dosis'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    onChanged : (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                      labelStyle: TextStyle(fontSize: 10,color: Colors.grey.shade400,fontWeight: FontWeight.w600, fontFamily: 'Dosis'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    onChanged : (value) {
                      _password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 10,color: Colors.grey.shade400,fontWeight: FontWeight.w600, fontFamily: 'Dosis'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    height: 50,
                    child: FlatButton(
                      onPressed: (){
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _email, 
                          password: _password).whenComplete(() => {
                            Navigator.pushReplacementNamed(context, '/homepage')
                          }).catchError((e) {print(e);
                          });
                      },
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffff5f6d),
                              Color(0xffff5f6d),
                              Color(0xffffc371),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(minHeight: 50,maxWidth: double.infinity),
                          child: Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontFamily: 'Dosis'),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(height: 30,),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("I'm already a member.",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Dosis'),),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacementNamed('/loginpage');
                      },
                      child: Text('Sign in.',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red, fontFamily: 'Dosis'),),
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