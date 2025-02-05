import 'package:flutter/material.dart';
import 'package:math_mini/core/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {'name': 'Ansari Saif', 'rollNo': '1'},
      {'name': 'Raul Fernandes', 'rollNo': '4'},
      {'name': 'Mohiuddin Merchant', 'rollNo': '16'},
      {'name': 'Ronal Pinto', 'rollNo': '35'},
      {'name': 'Oaish Qazi', 'rollNo': '39'},
      {'name': 'Prasad Shinde', 'rollNo': '56'},
    ];

    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: Column(
        children: [
          Image.asset(
            'assets/images/maths.gif',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Container(
              // height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: secondaryColor.withValues(alpha: 0.1),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Maths MiniProject',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        members.length,
                        (index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                members[index]["name"]!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                members[index]["rollNo"]!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
