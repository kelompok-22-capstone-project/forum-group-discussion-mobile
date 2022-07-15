import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';

import 'package:moot/models/provider/navigation_provider.dart';
import 'package:provider/provider.dart';

import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

class NavigationBottomWidget extends StatelessWidget {
  const NavigationBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<NavigationProvider>(builder: (context, value, _) {
        return FluidNavBar(
          animationFactor: 1,
          onChange: ((selectedIndex) {
            // final provider = Provider.of<NavigationProvider>(context, listen: false);
            value.setBottomNavItem(selectedIndex);
            // provider.setBottomNavItem(selectedIndex);
          }),
          icons: [
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomhome.svg", extras: {"label": "Home"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomsearch.svg", extras: {"label": "Search"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomadd.svg", extras: {"label": "Add"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomranking.svg", extras: {"label": "Ranking"}),
            FluidNavBarIcon(svgPath: "assets/images/icons/bottomprofile.svg", extras: {"label": "Profile"}),
          ],
          style: FluidNavBarStyle(
              barBackgroundColor: Colors.grey[50],
              iconUnselectedForegroundColor: Colors.grey[800],
              iconSelectedForegroundColor: createMaterialColor(const Color(0xff4C74D9))),
          scaleFactor: 1.5,
          defaultIndex: value.bottomNavItem,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        );
      });
}
