import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {

    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          // foregroundColor: Colors.black,
          backgroundColor: Color(0xFF3182B3),
          title: Text("FTS Bulk Cheque Printing Software"),
        ),
      ),

      body: Container(
              width: main_Width * 1,
        height: main_Height * 0.89,
        decoration: BoxDecoration(
          color: Colors.blue[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          ],
        ),
      ),


      bottomSheet: Container(
        height: main_Height * 0.06,
        width: main_Height * 10,
        decoration: BoxDecoration(color: Color(0xFF3182B1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                launch("https://feeltechsolutions.com/");
              },
              child: Text(
                "  www.feeltechsolutions.com ",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            Text(
              "  © FeelTech Solutions Pvt. Ltd.  |  +91 9687112390  |  connect@feeltechsolutions.com    ",
              style: TextStyle(color: Colors.white, fontSize: 22),
            )

          ],
        ),
      ),


    );
  }
}
