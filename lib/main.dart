import 'package:flutter/material.dart';
import 'package:math_mini/core/constants.dart';
import 'package:math_mini/view/pages/chart_screen.dart';
import 'package:math_mini/view/pages/coin_toss_screen.dart';
import 'package:math_mini/view/pages/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  static const int pageCount = 3;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff111111),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: [
              WelcomeScreen(),
              CoinTossScreen(),
              ChartScreen(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: _pageController,
                count: pageCount,
                onDotClicked: (value) {
                  _pageController.animateToPage(value, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                },
                effect: ExpandingDotsEffect(activeDotColor: Color(0xff50e3ff)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
