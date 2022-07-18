import 'package:flutter/material.dart';

import 'package:moot/models/provider/navigation_provider.dart';
import 'package:moot/models/provider/user_provider.dart';
import 'package:moot/screens/homepage/admin/categoryAdmin.dart';
import 'package:moot/screens/homepage/admin/dashboardAdmin.dart';
import 'package:moot/screens/homepage/admin/reportAdmin.dart';
import 'package:moot/screens/homepage/admin/threadAdmin.dart';

import 'package:provider/provider.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  _HomePageAdmin createState() => _HomePageAdmin();
}

class _HomePageAdmin extends State<HomePageAdmin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final value = Provider.of<UserProvider>(context, listen: false);
      await value.getOwnProfile();
    });
  }

  @override
  Widget build(BuildContext context) => buildPages();

  Widget buildPages() {
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.bottomNavItemAdmin;

    switch (navigationItem) {
      case 0:
        return DashboardAdmin();
      case 1:
        return CategoryAdmin();
      case 2:
        return ThreadAdmin();
      case 3:
        return ReportAdmin();
    }
    return DashboardAdmin();
  }
}
