import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

List<int> coinTossOutcomes(int trials) {
  if (trials == 0) {
    return List.generate(10, (index) => 0);
  }

  final random = Random();
  var tailsCount = List<int>.filled(10, 0);
  for (var trial = 0; trial < trials; trial++) {
    int tails = 0;
    for (var i = 0; i < 9; i++) {
      if (random.nextBool()) {
        tails++;
      }
    }
    tailsCount[tails]++;
  }

  return tailsCount;
}

List<dynamic> coinOutcomeGenerator() {
  final random = Random();
  int heads = 0;
  int tails = 0;
  List<bool> outcomes = List.generate(9, (_) => false);

  for (int i = 0; i < 9; i++) {
    final state = random.nextBool();
    outcomes[i] = state;

    if (state) {
      heads++;
    } else {
      tails++;
    }
  }

  return [outcomes, heads, tails];
}

SnackBar getSnackBar(title, message, contentType, {duration = 3}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    duration: Duration(seconds: duration),
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    ),
  );
}

String formatNumber(int value) {
  if (value >= 1000000) {
    return '${(value / 1000000).toStringAsFixed(1)}M';
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)}k';
  } else {
    return value.toString();
  }
}
