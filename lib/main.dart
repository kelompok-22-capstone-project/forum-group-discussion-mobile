import 'package:moot/components/theme.dart';
import 'package:moot/models/provider/auth_provider.dart';
import 'package:moot/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: createMaterialColor(const Color(0xff4C74D9)), fontFamily: 'Poppins'),
        home: const SplashFuturePage(),
      ),
    );
  }
}
