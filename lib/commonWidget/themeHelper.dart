import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class ThemeHelper{
  static final toast = FToast();


  static void customDialogForMessage(
      BuildContext context,
      String dialogTitle,
      double widthData,
      VoidCallback onOkayPress,
      {
        bool? autoRemoveDialog,
        required bool ForSuccess,
        InlineSpan? contentMessage,
        // double? heightData,
        bool? needMoreLines,
        bool? isBarrierDismissible,
      }
      ) {
    showDialog(
        barrierDismissible: isBarrierDismissible ?? true,
        context: context,
        builder: (context) {
          autoRemoveDialog == true
              ? Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          })
              : null ;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,

              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Color.fromARGB(255, 217, 231, 250),
                    color: Colors.white,
                  ),
                  width: widthData,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            dialogTitle.trim(),
                            maxLines: needMoreLines == true ? 4 :  2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                // color: darkRed,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 5,),
                        contentMessage != null
                            ? RichText(
                          text: contentMessage,
                          textAlign: TextAlign.center,
                        )
                            : Container(),
                        SizedBox(height: 20,),
                        TextButton(
                            onPressed: onOkayPress,
                            style: ButtonStyle(
                              // backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 57, 181, 74))
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                            ),
                            child: Text("OK", style: TextStyle(
                              color: Colors.white, fontSize: 14,),
                            )
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                    top: -30,
                    // top: -50,
                    child: Material(
                      borderRadius: BorderRadius.circular(60),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          // child: Image.asset("assets/images/app_icon_png.png", width: 60, height: 60,)
                          child: Container(
                            // padding: EdgeInsets.all(2),
                            child: ForSuccess ? Image.asset("assets/images/popup_success.png", width: 250, height: 250,) : Image.asset("assets/images/popup_failure.png", width: 250, height: 250,),
                          )
                      ),
                    )
                )
              ],
            ),
          );
        }
    );
  }

  static Widget buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(backgroundColor: Colors.black),
    );
  }

  static Widget buildCommonInitialWidgetScreen() {
    return const Scaffold(
      body: Center(
        child: Text("helllooooooo"),
      ),
    );
  }


  static Widget showToolTipWidget({
    required String message,
    required Widget child,
  })
  {
    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      child: child,
    );
  }

  static void toastForAPIFaliure(String message) {

    Fluttertoast.showToast(
        msg: "User Not Found,try Again..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }



}