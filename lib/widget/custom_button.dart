
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    
    super.key, required this.onPressed, required this.text,this.width = 100,

  
  });


  final VoidCallback onPressed;
  final double width;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      style: TextButton.styleFrom(
        fixedSize:  Size(width, 45),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
