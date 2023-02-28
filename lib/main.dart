import 'dart:async';
import 'package:cheque_print/UI/Dahboard/Dahboard.dart';
import 'package:cheque_print/UI/loginpage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // fontFamily: 'Cutive',
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
    // curve: Curves.easeIn,
  );

  // final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeIn,
  // );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const String KeyLogIn = "Login";

  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FadeTransition(
        opacity: _animation,
        child: Image.asset("assets/images/f1.png"),
      ),
    ));
  }

  void whereToGo() async {
    var sharedpref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedpref.getBool(KeyLogIn);

    Timer(Duration(seconds: 1), () {
      if (isLoggedIn != null) {
        print("abc");
        if (isLoggedIn) {
          print("abc");

          Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Dashboard()));
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Dashboard()));
        } else {
          print("abc");
          Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: LoginPage()));

          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } else {
        print("abc");
        Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: LoginPage()));

        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }
}


