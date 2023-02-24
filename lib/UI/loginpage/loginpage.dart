import 'dart:ffi';

// import 'package:cheque_print/UI/Dahboard.dart';
import 'package:cheque_print/UI/Dahboard/Dahboard.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool visiblePassowrd = true;

  String? email;
  String? password;


  @override
  Widget build(BuildContext context) {
    double main_Width = MediaQuery.of(context).size.width;
    double main_Height = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
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
                        image: AssetImage("assets/images/5.jpg"),
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
                        style: TextStyle(
                          letterSpacing: 2
                        ),
                        // initialValue: "abc@gmail.com",
                        validator: (value){
                          if(value == null){
                            return 'Id can\'t be empty';
                          }else if(value == "abc@gmail.com"){
                            return null;
                          }
                        },
                        onSaved: (onSavedVal) {
                          print(onSavedVal);
                          email = onSavedVal;
                        },
                        decoration: InputDecoration(
                          filled: true, //<-- SEE HERE
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: 'Enter Id : ',
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 10,bottom: 10,left: 40,right: 40),
                      child: TextFormField(
                        style: TextStyle(
                            letterSpacing: 2
                        ),
                        // initialValue: "Abc@123",
                        validator: (value){
                          String? validatePassword(String value) {
                            RegExp regex =
                            RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value.isEmpty) {
                              return 'Please enter password';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid password';
                              } else {
                                return null;
                              }
                            }
                          }
                        },
                        onSaved: (onSavedVal) {
                          print(onSavedVal);
                          password = onSavedVal;
                        },
                        decoration: InputDecoration(
                          filled: true, //<-- SEE HERE
                          fillColor: Colors.grey[300],
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
                          borderRadius: BorderRadius.circular(5),
                        ),

                        child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.save();

                            Text("emal : $email");
                            Text("pass : $password");

                            if(email == "abc@gmail.com" && password == "Abc@123"){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                            }else{

                              final snackBar = SnackBar(
                                content: const Text('Wrong Id or Password!'),
                                backgroundColor: Color(0xFF076799),
                                action: SnackBarAction(
                                  label: 'dismiss',
                                  onPressed: () {
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);


                            }
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
                            primary: Color(0xFF076799),
                          ),
                        ),
                      ),)


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
