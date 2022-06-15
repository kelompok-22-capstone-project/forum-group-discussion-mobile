import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:moot/components/theme.dart';
import 'package:moot/screens/auth/login_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        pageColor: Colors.white,
        imagePadding: EdgeInsets.zero,
        imageFlex: 2);

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 16),
            child: TextButton(
              child: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w700)),
              onPressed: () => _onIntroEnd(context),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          titleWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Find ",
                  style: TextStyle(
                      color: createMaterialColor(const Color(0xff4C74D9)),
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: "your ", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "interest ",
                  style: TextStyle(
                      color: createMaterialColor(const Color(0xff4C74D9)), fontSize: 23, fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: "easilly ", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
            ]),
          ),
          body: "Find unlimited discussion places according to your interests.",
          image: Image.asset('assets/images/img1.png', width: 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Create ",
                  style: TextStyle(
                      color: createMaterialColor(const Color(0xff4C74D9)),
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: "your ", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: "own ", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "thread ",
                  style: TextStyle(
                      color: createMaterialColor(const Color(0xff4C74D9)), fontSize: 23, fontWeight: FontWeight.bold)),
            ]),
          ),
          body: "Create and share your thread whenever, wherever.",
          image: Image.asset('assets/images/img2.png', width: 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: <TextSpan>[
              const TextSpan(
                  text: "Let's ", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "connect ",
                  style: TextStyle(
                      color: createMaterialColor(const Color(0xff4C74D9)),
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: "the ", style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "world ",
                  style: TextStyle(
                      color: createMaterialColor(const Color(0xff4C74D9)), fontSize: 23, fontWeight: FontWeight.bold)),
            ]),
          ),
          body: "Make some connections and get new insights",
          image: Image.asset('assets/images/img3.png', width: 350),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb ? const EdgeInsets.all(12.0) : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
