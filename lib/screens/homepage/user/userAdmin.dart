import 'package:flutter/material.dart';
import 'package:moot/screens/homepage/user/navigation_bottom_widget.dart';

class UserAdmin extends StatefulWidget {
  @override
  State<UserAdmin> createState() => _UserAdmin();
}

class _UserAdmin extends State<UserAdmin> {
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                color: Colors.black,
              )),
          title: Text('Create Thread'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
      );
}
