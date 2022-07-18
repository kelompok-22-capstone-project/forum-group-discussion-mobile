import 'package:flutter/material.dart';

class EmptyResult extends StatelessWidget {
  const EmptyResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
      child: Column(
        children: [
          Image.asset('assets/images/empty.png'),
          SizedBox(height: 50),
          Text(
            "No result",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          Text(
            "We couldn’t find what you searched for. Try searching again.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
