import 'package:cheque_print/UI/Dahboard/Dahboard.dart';
import 'package:cheque_print/UI/Logprint/LogPrint.dart';
import 'package:cheque_print/UI/SignUp/SignUp.dart';
import 'package:cheque_print/network/repositary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import '../../api/api.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../commonWidget/themeHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool visiblePassowrd = true;

  // final toast = FToast();
  LoginScreenBloc loginBloc = LoginScreenBloc(Repository.getInstance());

  String? email;
  String? password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: BlocProvider<LoginScreenBloc>(
        create: (context) => loginBloc..add(LoginScreenInitialEvent()),
        child: BlocConsumer<LoginScreenBloc, LoginScreenStates>(
          builder: (context, state) {
            if (state is LoginScreenLoadingState) {
              return ThemeHelper.buildLoadingWidget();
            } else {
              return mainLoginForm();
            }
          },
          listener: (context, state) async {
            if (state is APIFailureState) {
              print(" mess : ${state.exception.toString()}");

              final main_width = MediaQuery.of(context).size.width;

                ThemeHelper.customDialogForMessage(
                  autoRemoveDialog: true,
                    isBarrierDismissible: false,
                    context,
                    "${state.exception.toString().replaceAll("Exception: No Internet :", "").replaceAll("Exception: User Not Found :", "")}!",
                    main_width * 0.25,
                    // contentMessage: contentMes,
                        () {
                      // Navigator.of(context).pop('refresh');
                      Navigator.of(context).pop();
                      // Navigator.of(context).pop('refresh');
                    },
                    ForSuccess: false);



            } else
              if (state is PostLoginDataEventState) {

              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));

              accessToken = state.loginResponseData.accessToken;
              cDate = state.loginResponseData.cDate;
              eDate = state.loginResponseData.eDate;
              sDate = state.loginResponseData.sDate;
              companyName = state.loginResponseData.companyName;

            } else {



            }

          },
        ),
      ),

    );
  }

  Widget mainLoginForm() {
    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;

    return Scaffold(

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
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            Text(
              "  © FeelTech Solutions Pvt. Ltd.  |  +91 9687112390  |  connect@feeltechsolutions.com    ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )

          ],
        ),
      ),


      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/mic.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/w9.jpg"),
                    fit: BoxFit.fill
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/f1.png"),
                    SizedBox(height: 35,),
                    Padding(padding: EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                      child: TextFormField(
                        // autovalidateMode: AutovalidateMode.always,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value){

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));

                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            loginBloc
                                .add(PostLoginDataEvent(email!, password!));
                          }

                          print("email : $email , password $password");



                        },

                        // initialValue: "connect@feeltechsolutions.com",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(
                              "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (value == null || value.isEmpty) {
                            return 'Email can\'t be empty';
                          } else if (!regex.hasMatch(value)) {
                            return ("Please check your email address");
                          }
                          return null;
                        },
                        onSaved: (onSavedVal) {
                          print(onSavedVal);
                          email = onSavedVal;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                            labelText: 'User Name ',
                            hintText: "Enter Id "
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value){

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));

                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            loginBloc
                                .add(PostLoginDataEvent(email!, password!));
                          }

                          print("email : $email , password $password");



                        },

                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2
                        ),
                        // initialValue: "AdminFTS@911",
                        validator: (value) {
                          if (value == null || value.isEmpty) {

                          }
                          return null;
                        },
                        onSaved: (onSavedVal) {
                          password = onSavedVal;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Password ',
                          suffixIcon: IconButton(
                            icon: Icon(
                              visiblePassowrd
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                visiblePassowrd = !visiblePassowrd;
                              });
                            },
                          ),
                        ),
                        obscureText: visiblePassowrd,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Padding(padding: EdgeInsets.only(top: 10,left: 100,right: 100),
                      child: Container(
                        width:  double.infinity,
                        height: main_Height * 0.05,
                        decoration: BoxDecoration(
                          color: Color(0xFF076799),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {

                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                      //
                      // DateTime dt1 = DateTime.parse(sDate!);
                      // DateTime dt2 = DateTime.parse(cDate!);
                      // DateTime dt3 = DateTime.parse(eDate!);

                      // if(dt2.isAfter(dt3)){
                      //   print("expired here");
                      // }else{
                      // }

                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              loginBloc
                                  .add(PostLoginDataEvent(email!, password!));
                            }

                            print("email : $email , password $password");



                            //
                            // Navigator.of(context).push
                            //   (MaterialPageRoute(builder: (context)=>LogPrint()));


                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 2
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Color(0xFF3182B3)
                          ),
                        ),
                      ),
                    ),

                    // ElevatedButton(onPressed: (){
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                    // }, child: Text("Enter")),

                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "Don't have an account?",
                    //         style: TextStyle(
                    //             fontSize: 20, color: Color(0xFF646982)),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       TextButton(
                    //         onPressed: () => {
                    //           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()))
                    //         },
                    //         child: Text(
                    //           "SIGN UP",
                    //           style: TextStyle(
                    //             fontSize: 25,
                    //             // color: Color(0xFFFF7622),
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold,
                    //             fontStyle: FontStyle.italic,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
