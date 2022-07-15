import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';

import 'package:moot/models/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class NavigationBottomWidgetAdmin extends StatelessWidget {
  const NavigationBottomWidgetAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<NavigationProvider>(builder: (context, value, _) {
        return FluidNavBar(
          animationFactor: 1,
          onChange: ((selectedIndex) {
            value.setBottomNavItemAdmin(selectedIndex);
          }),
          icons: [
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomhome.svg", extras: {"label": "Dashboard"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomcategory.svg", extras: {"label": "Category"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomthread.svg", extras: {"label": "Thread"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomreport.svg", extras: {"label": "Report"}),
          ],
          style: FluidNavBarStyle(
              barBackgroundColor: Colors.grey[50],
              iconUnselectedForegroundColor: Colors.grey[800],
              iconSelectedForegroundColor: createMaterialColor(const Color(0xff4C74D9))),
          scaleFactor: 1.5,
          defaultIndex: value.bottomNavItemAdmin,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        );
      });
}
