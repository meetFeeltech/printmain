import 'package:flutter/material.dart';

class LogPrint extends StatefulWidget {
  const LogPrint({Key? key}) : super(key: key);

  @override
  State<LogPrint> createState() => _LogPrintState();
}

class _LogPrintState extends State<LogPrint> {
  @override
  Widget build(BuildContext context) {

    final main_width = MediaQuery.of(context).size.width;
    final main_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Color(0xFF3182B3),
          title: Text("FTS Bulk Cheque Printing Softwere"),
        ),
      ),

      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("abc"),

              ],
            ),
          ),),


          Container(
            height: main_height * 0.06,
            width: main_height * 10,
            decoration: BoxDecoration(color: Color(0xFF3182B1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "  © FeelTech Solutions Pvt. Ltd.  |  M: 9099240066  |  E: connect@feeltechsolutions.com ",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                // Text(
                //   "M - 9099240066, E -  connect@feeltechsolutions.com  ",
                //   style: TextStyle(color: Colors.white, fontSize: 20),
                // ),
              ],
            ),
          )

        ],
      )

    );
  }
}
