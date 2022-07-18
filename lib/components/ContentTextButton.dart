import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moot/models/provider/thread_provider.dart';
import 'package:provider/provider.dart';

class TextButtonWidget extends StatelessWidget {
  final String buttonText;
  final int index;
  final Function onpressed;
  final Color color;

  final String asset;

  TextButtonWidget(
      {required this.buttonText,
      required this.index,
      required this.onpressed,
      required this.asset,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThreadProvider>(builder: (context, value, _) {
      return TextButton.icon(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(color: Colors.blue),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
        onPressed: () {
          onpressed();
        },
        icon: SvgPicture.asset(
          asset,
          height: 20,
          width: 20,
          color: color,
        ),
        label: Text(
          buttonText,
          style: TextStyle(color: color, fontSize: 20),
        ),
      );
    });
  }
}
