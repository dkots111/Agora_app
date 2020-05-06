import '../utils/data.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin{

  PageController _pageController;
  AnimationController _animationController;
  int _currentPage = 0;

  @override
  void initState() {
   _pageController = PageController(initialPage: 0);
   _animationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          child: PageView.builder(
            itemCount: pageList.length,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context,index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context,child) {
                      child:  return _buildPage(context,pageList[index]);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, PageModel page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(page.imageUrl),
        SizedBox(height: 40.0),
        Text(
          page.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Dosis'
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          page.body,
          style: TextStyle(
            fontSize: 15.0,
            color: Color(0xFFCCCCCC),
            fontWeight: FontWeight.bold,
            fontFamily: 'Dosis'
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: _buildPageIndicator(),
        ),
        _buildGetStartedButton(context),
        _buildLoginButton(context)
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < pageList.length; i++)
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
            color: _currentPage == i ? Color(0xFFFCC75D) : Colors.grey[400],
            borderRadius: BorderRadius.circular(12.0)
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return InkWell(
     onTap:  () {
       Navigator.of(context).pushReplacementNamed('/signup');
       },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFFCC75D),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'Dosis')),
        ),
      ),
    );
  }


  Widget _buildLoginButton(BuildContext context) {
     return InkWell(
       onTap: () {
        Navigator.of(context).pushReplacementNamed('/loginpage');
       },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFFCC75D)),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Text('Login', style: TextStyle(color: Color(0xFFFCC75D), fontSize: 20.0, fontFamily: 'Dosis')),
        ),
      ),
    );
  }
}