import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String buttonText;

  final Function onpressed;
  final int color;

  CategoryButtonWidget({required this.buttonText, required this.onpressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(50, 35)),
        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 165, 185, 234)),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () {
        onpressed();
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xff064AB8),
        ),
      ),
    );
  }
}
