import 'package:flutter/material.dart';
import 'package:moot/screens/auth/login_screen.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Consumer<AuthProvider>(builder: (context, value, child) {
        return Center(
            child: ElevatedButton(
          child: const Text("logout"),
          onPressed: () async {
            await value.logoutUser();
            if (value.login == null) {
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
            }
          },
        ));
      }),
    );
  }
}
