import 'package:decopalst/asosiy.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: PageView(
                controller: _pageController,
                children: [
                 
                  Container(
                    width: 200,
                    height: 200,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
 // mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    const SizedBox(width: 20.0, height: 100.0),
    const Text(
      'DECO',
      style: TextStyle(fontSize: 43.0),
    ),
    const SizedBox(width: 20.0, height: 100.0),
    DefaultTextStyle(
      style: const TextStyle(
        fontSize: 40.0,
        fontFamily: 'Horizon',
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          RotateAnimatedText('plast'),
          RotateAnimatedText('panel'),
          RotateAnimatedText('dekorative'),
        ],
        onTap: () {
          print("Tap Event");
        },
      ),
    ),
  ],
) //buildPage("", "Welcome to Page 1")
                    ),
                    
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/ombor.png"),
                  ),
             
                  buildPage("mn.png", "Enjoy Page 3"),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: ExpandingDotsEffect(
                  activeDotColor: Color.fromARGB(255, 208, 209, 210),
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ],
          ),
         // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenMain(),
                ),
              );
            },
            child: ClayContainer(
              borderRadius: 12,
              depth: 20,
              color:  const Color.fromARGB(255, 226, 232, 234)!,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 114, 113, 113), // Adjust text color for visibility
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String imagePath, String title) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
     
    
    );
  }
}