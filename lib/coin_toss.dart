import 'dart:math';

import 'package:flutter/material.dart';

class CoinTossPage extends StatefulWidget {
  const CoinTossPage({super.key});

  @override
  State<CoinTossPage> createState() => _CoinTossPageState();
}

class _CoinTossPageState extends State<CoinTossPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationCtrl;
  late Animation<double> verticalMovment;
  late Animation<double> rotation;
  final random = Random();
  late bool isHeads;
  @override
  void initState() {
    super.initState();

    animationCtrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    verticalMovment = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: -100),
        weight: 10,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -100, end: 0),
        weight: 10,
      ),
    ]).animate(animationCtrl);

    rotation = Tween<double>(
      begin: 0,
      end: 2 * pi * 10,
    ).animate(animationCtrl);

    isHeads = random.nextBool();
  }

  void tossCoin() {
    double stopPosition = random.nextBool() ? 0.0 : 0.5;
    animationCtrl.value = stopPosition;
    animationCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: animationCtrl,
              builder: (BuildContext context, Widget? child) {
                double verticalOffset = verticalMovment.value;
                double value = rotation.value % (2 * pi);
                // isHeads = value < pi;
                isHeads = random.nextBool();

                return Transform.translate(
                  offset: Offset(0, verticalOffset),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(value),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2, 3),
                            color: Colors.blueGrey,
                          )
                        ],
                        shape: BoxShape.circle,
                        // color: isHeads ? Colors.blueAccent : Colors.blueGrey,
                      ),
                      child: Center(
                        child: Image.asset(
                          isHeads
                              ? 'assets/images/heads.png'
                              : 'assets/images/tails.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: tossCoin,
              child: Text('Toss Coin'),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    super.dispose();
  }
}
