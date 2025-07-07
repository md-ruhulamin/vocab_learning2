import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: Lottie.asset(
            'assets/images/Animation - 1749106532062.json',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
      );
    },
  );
}
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}