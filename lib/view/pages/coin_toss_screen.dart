import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:math_mini/core/constants.dart';
import 'package:math_mini/core/utils.dart';

class CoinTossScreen extends StatefulWidget {
  const CoinTossScreen({super.key});

  @override
  State<CoinTossScreen> createState() => _CoinTossScreenState();
}

class _CoinTossScreenState extends State<CoinTossScreen> with SingleTickerProviderStateMixin {
  bool coinState = true;
  List<bool> coinOutcomes = [true, true, true, true, true, true, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111111),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(coinOutcomes.length, (index) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor, width: 2),
                    color: secondaryColor.withAlpha(30),
                  ),
                  child: Center(
                    child: HugeIcon(
                      icon: coinOutcomes[index] ? HugeIcons.strokeRoundedGitlab : HugeIcons.strokeRoundedOlympicTorch,
                      color: primaryColor,
                      size: 48,
                    ),
                  ),
                );
              }),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.75),
            child: GestureDetector(
              onTap: () {
                final arr = coinOutcomeGenerator();
                final [outcomes, heads, tails] = arr;

                print(arr);

                setState(() {
                  coinOutcomes = outcomes;
                });

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(getSnackBar(
                    'Coin Toss Outcome',
                    'We got $heads Heads and $tails Tails!!!',
                    ContentType.help,
                  ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(color: secondaryColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Toss 9 coins simultaneously',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
