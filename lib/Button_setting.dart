import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColors;
  final String buttonText;
  final buttonTapped;
  MyButton({
    this.color,
    this.textColors,
    required this.buttonText,
    this.buttonTapped,
  });
  // const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColors,fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
