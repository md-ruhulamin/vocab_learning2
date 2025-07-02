
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/audio/audio_controller.dart';


class SpeakTheWord extends StatelessWidget {
  
  const SpeakTheWord({
    super.key,
    required this.text,
  
  });

  final String  text;


  @override
  Widget build(BuildContext context) {
      final TTSController ttsController = Get.put(TTSController());
    return InkWell(
      onTap: () {
        ttsController.speak(text);
      },
      child:Icon(Icons.volume_up, size: 20, color: Colors.blue.shade800) // You can customize the icon and its size,
    );
  }
}
