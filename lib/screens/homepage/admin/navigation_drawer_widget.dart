import 'package:flutter/material.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/models/navigation_item.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:moot/models/provider/navigation_provider.dart';
import 'package:moot/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationDrawerWidget extends StatelessWidget {
  static final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                padding: padding,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Admin',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: createMaterialColor(const Color(0xff4C74D9))),
                        ),
                      ),
                    ),
                    buildMenuItem(
                      context,
                      item: NavigationItem.dashboard,
                      text: 'Dashboard',
                      icon: SvgPicture.asset('assets/images/icons/Home.svg'),
                      iconActive: SvgPicture.asset('assets/images/icons/HomeActive.svg'),
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(context,
                        item: NavigationItem.user,
                        text: 'User',
                        icon: SvgPicture.asset('assets/images/icons/User.svg'),
                        iconActive: SvgPicture.asset('assets/images/icons/UserActive.svg')),
                    const SizedBox(height: 16),
                    buildMenuItem(context,
                        item: NavigationItem.category,
                        text: 'Category',
                        icon: SvgPicture.asset('assets/images/icons/Element.svg'),
                        iconActive: SvgPicture.asset('assets/images/icons/ElementActive.svg')),
                    const SizedBox(height: 16),
                    buildMenuItem(context,
                        item: NavigationItem.report,
                        text: 'Report',
                        icon: SvgPicture.asset('assets/images/icons/Report.svg'),
                        iconActive: SvgPicture.asset('assets/images/icons/ReportActive.svg')),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthProvider>().logoutUser();
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Color(0xffFF7262),
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(fontSize: 18, color: Color(0xffFF7262)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem(BuildContext context,
      {required NavigationItem item, required String text, required Widget icon, required Widget iconActive}) {
    final provider = Provider.of<NavigationProvider>(context);
    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    final colorText = isSelected ? Colors.white : createMaterialColor(const Color(0xff4C74D9));
    final colorBg = isSelected ? createMaterialColor(const Color(0xff4C74D9)) : Colors.transparent;
    final myIcon = isSelected ? iconActive : icon;

    return Material(
      child: Container(
        decoration: BoxDecoration(color: colorBg, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          selected: isSelected,
          selectedTileColor: Colors.white24,
          leading: myIcon,
          title: Text(text, style: TextStyle(color: colorText, fontSize: 16)),
          onTap: () => selectItem(context, item),
        ),
      ),
    );
  }

  void selectItem(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context, listen: false);
    provider.setNavigationItem(item);
  }
}
