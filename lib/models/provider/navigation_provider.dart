import 'package:flutter/material.dart';
import 'package:moot/models/navigation_item.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationItem _navigationItem = NavigationItem.dashboard;
  NavigationItem get navigationItem => _navigationItem;

  NavigationItemAdmin _navigationItemAdmin = NavigationItemAdmin.dashboard;
  NavigationItemAdmin get navigationItemAdmin => _navigationItemAdmin;

  int _bottomNavItem = 0;
  int get bottomNavItem => _bottomNavItem;

  int _bottomNavItemAdmin = 0;
  int get bottomNavItemAdmin => _bottomNavItemAdmin;

  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }

  void setBottomNavItem(int bottomNavItem) {
    _bottomNavItem = bottomNavItem;

    notifyListeners();
  }

  void setNavigationItemAdmin(NavigationItemAdmin navigationItemAdmin) {
    _navigationItemAdmin = navigationItemAdmin;

    notifyListeners();
  }

  void setBottomNavItemAdmin(int bottomNavItemAdmin) {
    _bottomNavItemAdmin = bottomNavItemAdmin;

    notifyListeners();
  }
}
