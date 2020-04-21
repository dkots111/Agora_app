import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';
import 'dart:math' as math;

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> with SingleTickerProviderStateMixin {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 0.0,
        duration: Duration(seconds: 5),
        upperBound: 1,
        lowerBound: -1,
        vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Color(0xFFE06478), Color(0xFFFCDD89)],
                      ),
                    ),
                  ),
                  builder: (BuildContext context, Widget child) {
                    return ClipPath(
                      clipper: DrawClip(_controller.value),
                      child: child,
                    );
                  }),
              Container(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  'Agora',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  'Your video calling app',
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontFamily: 'Nunito'),
                ),
              ),
            ],
          ),
          Text(
            'Join channel',
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 18.0),
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: 'Nick Name',
                  hintStyle: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 10,
                      fontFamily: 'Nunito'),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)))),
            ),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 18.0),
            child: TextField(
              controller: _channelController,
              obscureText: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: 'Channel Name',
                  hintStyle: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 10,
                      fontFamily: 'Nunito'),
                  contentPadding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 38),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)))),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 70.0),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Center(
              child: RaisedButton(
                onPressed: onJoin,
                color: Color(0xFFE06478),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Join',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0)),
                padding: EdgeInsets.all(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);

    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);

    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
