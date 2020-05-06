import 'package:agora_flutter_quickstart/src/pages/LoginPage.dart';
import 'package:agora_flutter_quickstart/src/pages/Onboarding.dart';
import 'package:agora_flutter_quickstart/src/pages/SignUp.dart';
import 'package:agora_flutter_quickstart/src/pages/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingPage(),
      routes: <String, WidgetBuilder> {
        '/onboardingpage' : (BuildContext context) => OnboardingPage(),
        '/landingpage' : (BuildContext context) => MyApp(),
        '/signup' : (BuildContext context) => SignupPage(),
        '/homepage' : (BuildContext context) => IndexPage(),
        '/loginpage' : (BuildContext context) => LoginPage()
      },
    );
  }
}
