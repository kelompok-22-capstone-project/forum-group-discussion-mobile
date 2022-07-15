import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String amount;
  final Widget icon;
  final int color;
  final int color2;

  CustomListTile(
      {required this.title, required this.amount, required this.icon, required this.color, required this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          color: createMaterialColor(Color(color)),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(color),
              Color(color),
            ],
          )),
      child: ListTile(
        subtitle: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        title: Container(
          child: Text(
            amount.toString(),
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
