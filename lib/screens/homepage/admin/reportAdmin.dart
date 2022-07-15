import 'package:flutter/material.dart';
import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';

class ReportAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Report'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        bottomNavigationBar: NavigationBottomWidgetAdmin(),
      );
}
