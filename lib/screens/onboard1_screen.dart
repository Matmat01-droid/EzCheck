import 'package:ezcheck_app/intro_screens/intro.page3.dart';
import 'package:ezcheck_app/intro_screens/intro_page1.dart';
import 'package:ezcheck_app/intro_screens/intro_page2.dart';
import 'package:ezcheck_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({Key? key}) : super(key: key);

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  // Controller to keep track of which page we're on
  PageController _controller = PageController();
  // Variable to track if the last page is reached
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    //Listen to page changes to update the isLastPage variable
    _controller.addListener(() {
      setState(() {
        isLastPage = _controller.page == 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          SizedBox(
              height: 200,
              child: Image.asset('assets/images/EzCheckText1.png')),
          Container(
            alignment: Alignment(0, 0.30),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 9,
                  activeDotColor: Color(0xff5B8291),
                  dotColor: Color(0xFF31434F)),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            right: 20.0,
            child: ElevatedButton(
              onPressed: () {
                if (_controller.page == 2) {
                  // Navigate to the next screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF31434F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    isLastPage ? 'Get Started' : 'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
