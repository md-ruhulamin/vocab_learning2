import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  String getGreeting() {
    // Set time to Bangladesh timezone (UTC+6)
    final now = DateTime.now().toUtc().add(const Duration(hours: 6));
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return "🌅 Good Morning!\n\n Ready to learn new words?";
    } else if (hour >= 12 && hour < 17) {
      return "🌞 Good Afternoon!\n\n Keep expanding your vocabulary!";
    } else if (hour >= 17 && hour < 20) {
      return "🌇 Good Evening!\n\n Time to sharpen your English!";
    } else {
      return "🌙 Good Night!\n\n Review a few words before bed.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getGreeting(),
      style: const TextStyle(
        color: Colors.white ,
        fontSize: 20, fontWeight: FontWeight.w600),
    );
  }
}
