import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/navigation_item.dart';
import 'package:moot/models/provider/navigation_provider.dart';
import 'package:moot/models/provider/user_provider.dart';
import 'package:moot/screens/homepage/user/SearchUser.dart';
import 'package:moot/screens/homepage/user/addThreadScreen.dart';
import 'package:moot/screens/homepage/user/dashboardUser.dart';
import 'package:moot/screens/homepage/user/rankingUser.dart';
import 'package:moot/screens/homepage/user/profileUser.dart';

import 'package:provider/provider.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUser createState() => _HomeUser();
}

class _HomeUser extends State<HomeUser> {
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
    final navigationItem = provider.bottomNavItem;
    final value = Provider.of<UserProvider>(context, listen: false);
    String? username = value.userData?.data?.username;

    switch (navigationItem) {
      case 0:
        return DashboardUser();
      case 1:
        return SearchUser();
      case 2:
        return AddThreadScreen();
      case 3:
        return RankingUser();
      case 4:
        return ProfileUser(username: "${username}");
    }
    return DashboardUser();
  }
}
