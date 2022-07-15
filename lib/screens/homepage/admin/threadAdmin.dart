import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';

class ThreadAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'User',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(color: createMaterialColor(const Color(0xff4C74D9)), fontSize: 18),
                    ),
                    Image.asset('assets/images/icons/refresh.png')
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: NavigationBottomWidgetAdmin(),
      );
}
