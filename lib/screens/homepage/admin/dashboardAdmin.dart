import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moot/components/CustomListTile.dart';
import 'package:moot/models/provider/admin_provider.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:moot/screens/auth/login_screen.dart';
import 'package:moot/screens/homepage/admin/navigation_bottom_widget_Admin.dart';

import 'package:provider/provider.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({Key? key}) : super(key: key);

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AdminProvider>(context, listen: false).getAdminDashboar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/logo.png', height: 60, width: 60),
        elevation: 0.3,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logoutUser();
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
            },
            icon: Icon(Icons.logout),
            color: Color(0xffFF7262),
          )
        ],
      ),
      body: Consumer<AdminProvider>(builder: (context, value, _) {
        final isLoading = value.state == AdminProviderState.loading;
        final isError = value.state == AdminProviderState.error;

        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      foregroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/exampleAvatar.png'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Admin", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                        Text("Kelompok 22", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomListTile(
                    title: 'Total User',
                    amount: "${value.adminData?.data?.totalUser}",
                    icon: SvgPicture.asset('assets/images/icons/Potrait.svg'),
                    color: 0xff4C74D9,
                    color2: 0xff6B8CE0,
                  ),
                  CustomListTile(
                    title: 'Total Moderator',
                    amount: "${value.adminData?.data?.totalModerator}",
                    icon: Image.asset('assets/images/icons/moderator.png'),
                    color: 0xffFF7262,
                    color2: 0xFF8F82,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomListTile(
                    title: 'Total Threads',
                    amount: "${value.adminData?.data?.totalThread}",
                    icon: SvgPicture.asset('assets/images/icons/document.svg'),
                    color: 0xffFF7262,
                    color2: 0xFF8F82,
                  ),
                  CustomListTile(
                    title: 'Total Report',
                    amount: "${value.adminData?.data?.totalReport}",
                    icon: SvgPicture.asset('assets/images/icons/shield.svg'),
                    color: 0xff4C74D9,
                    color2: 0xff6B8CE0,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: NavigationBottomWidgetAdmin(),
    );
  }
}
