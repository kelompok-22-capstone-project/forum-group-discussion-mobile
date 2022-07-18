import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:moot/screens/homepage/user/profileUser.dart';

class RangkingCard extends StatelessWidget {
  final int index;
  final String picture;
  final BuildContext context;

  final String name;
  final String subName;

  RangkingCard(
      {required this.index, required this.picture, required this.context, required this.name, required this.subName});

  Widget customItem(int index) {
    Color warna = Color(0xFFC49C48);

    if (index == 1) {
      warna = Color(0xFFC0C0C0);
    } else if (index == 2) {
      warna = Color(0xFFB0724A);
    }

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser(username: subName)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 0),
                leading: CircleAvatar(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    picture,
                    scale: 0.5,
                  ),
                ),
                title: Text(name),
                subtitle: Text(
                  subName,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/bottomranking.svg',
                      color: warna,
                    ),
                    Text(
                      '#${index + 1}',
                      style: TextStyle(color: warna, fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (index < 3) {
      return customItem(index);
    }
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser(username: subName)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 0),
                leading: CircleAvatar(
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    picture,
                    scale: 0.5,
                  ),
                ),
                title: Text(name),
                subtitle: Text(
                  subName,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '#${index + 1}',
                      style: TextStyle(color: Color(0xff4C74D9), fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
