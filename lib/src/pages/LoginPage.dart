import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget{

  String _email = '';
  String _password = '';

  GoogleSignIn googleAuth = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signInwWithGoogle() async {
    var googleSignInAccount = await googleAuth.signIn();
    var googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken, 
      accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult = await auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

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
                  Text('Welcome,',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold, fontFamily: 'Dosis')),
                  SizedBox(height: 6,),
                  Text('Sign in to continue!',style: TextStyle(fontSize: 16,color: Colors.grey.shade400),),
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    onChanged : (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                      labelStyle: TextStyle(fontSize: 10,color: Colors.grey.shade400, fontFamily: 'Dosis' ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 10,color: Colors.grey.shade400, fontFamily: 'Dosis'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  SizedBox(height: 30,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email, 
                          password: _password).then((user) {
                            Navigator.of(context).pushReplacementNamed('/homepage');
                          }).catchError((e) {
                            print(e);
                          });
                      },
                      padding: EdgeInsets.all(0),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffff5f6d),
                              Color(0xffff5f6d),
                              Color(0xffffc371),
                            ],
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                          child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontFamily: 'Dosis'),textAlign: TextAlign.center,),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: (){
                       signInwWithGoogle().whenComplete(() => {
                         Navigator.of(context).pushReplacementNamed('/homepage')
                       });
                      },
                      color: Colors.indigo.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('images/google.png',height: 20,width: 20,),
                          SizedBox(width: 10,),
                          Text('Connect with Google',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold, fontFamily: 'Dosis'),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("I'm a new user.",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Dosis', fontSize: 15),),
                    GestureDetector(
                      onTap: (){
                       Navigator.of(context).pushReplacementNamed('/signup');
                      },
                      child: Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red, fontFamily: 'Dosis'),),
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