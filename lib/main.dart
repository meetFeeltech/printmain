import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cheque_print/UI/Dahboard/Dahboard.dart';
import 'package:cheque_print/UI/loginpage/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    minimumSize: Size(1280, 720),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  }
  );

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
        // primarySwatch: Colors.blue,
        // fontFamily: 'Cutive',
      ),
      home:  Scaffold(
    body: AnimatedSplashScreen(
    splash: Center(
      child: Image.asset("assets/images/f1.png",
      height: 300,width: 300,),
    ),
    splashTransition: SplashTransition.fadeTransition,
    nextScreen: LoginPage(),
    splashIconSize: 200,
    backgroundColor: Colors.white,
    duration: 1500,
    animationDuration: Duration(milliseconds: 1500),
    ),
    ),
    );
  }

}

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);
//
//   @override
//   State<Splash> createState() => SplashState();
// }
//
// class SplashState extends State<Splash> with TickerProviderStateMixin {
//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(seconds: 1),
//     vsync: this,
//   )..repeat(reverse: true);
//   late final Animation<double> _animation = CurvedAnimation(
//     parent: _controller,
//     curve: Curves.ease,
//     // curve: Curves.easeIn,
//   );
//
//   // final Animation<double> _animation = CurvedAnimation(
//   //   parent: _controller,
//   //   curve: Curves.easeIn,
//   // );
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   static const String KeyLogIn = "Login";
//
//   @override
//   void initState() {
//     super.initState();
//     whereToGo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: FadeTransition(
//         opacity: _animation,
//         child: Image.asset("assets/images/f1.png"),
//       ),
//     ));
//   }
//
//   void whereToGo() async {
//     var sharedpref = await SharedPreferences.getInstance();
//     var isLoggedIn = sharedpref.getBool(KeyLogIn);
//
//     Timer(Duration(seconds: 1), () {
//       if (isLoggedIn != null) {
//         print("abc");
//         if (isLoggedIn) {
//           print("abc");
//
//           Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: Dashboard()));
//           // Navigator.of(context)
//           //     .push(MaterialPageRoute(builder: (context) => Dashboard()));
//         } else {
//           print("abc");
//           Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: LoginPage()));
//
//           // Navigator.of(context)
//           //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
//         }
//       } else {
//         print("abc");
//         Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: LoginPage()));
//
//         // Navigator.of(context)
//         //     .push(MaterialPageRoute(builder: (context) => LoginPage()));
//       }
//     });
//   }
// }
//
//
