import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:escapingplan/Modal/loginmodel.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/screen/mytrips1.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/sharedpreferance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class login1 extends StatefulWidget {
  const login1({Key? key}) : super(key: key);

  @override
  State<login1> createState() => _login1State();
}

class _login1State extends State<login1> {
  // String? token;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool visible = true;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   getdata();

  }
  getdata()async{
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }
// main ui
  design(){
  return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "assets/escape.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          key: _scaffoldState,
          // drawer: drawer1(context),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40.h,
                    ),

                    SizedBox(height: 3.h),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        validator: (value) {
                          String p = "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                          //Convert string p to a RegEx
                          RegExp regExp = RegExp(p);
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          } else {
                            //If email address matches pattern
                            if (regExp.hasMatch(value)) {
                              return null;
                            } else {
                              //If it doesn't match
                              return 'Email is not valid';
                            }
                          }
                        },
                        decoration: inputDecoration(
                          icon: const Icon(null),
                          hint: "Email",
                          click: () {},
                          icon1: const Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: TextFormField(
                        obscureText: visible,
                        keyboardType: TextInputType.text,
                        controller: _password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your passcode';
                          }
                          return null;
                        },
                        decoration: inputDecoration(
                          hint: "Itinerary Passcode",
                          icon1: const Icon(Icons.lock),
                          click: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: visible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade700,
                              offset: const Offset(0, 20),
                              blurRadius: 20,
                              spreadRadius: -5,
                            ),
                          ],
                          // border: Border.all(color: Colors.white,width: 1.0)
                        ),
                        height: 50.0,
                        child: TextButton(
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            // backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 1.h),
                            ),
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.sp),
                                )),
                          ),
                          onPressed: () async {
                            // login("1234");
                            setString();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14.sp,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.login,
                                color: Colors.grey.shade700,
                              )
                              // const Icon(
                              //   Icons.navigate_next,
                              //   color: Colors.white,
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20.h,),
                  ]),
            ),
          ),
        ),
      ]);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return design();
  }

  InputDecoration inputDecoration({
    required Icon icon1,
    required VoidCallback click,
    required String hint,
    required Icon icon,
  }) {
    return InputDecoration(
        contentPadding: const EdgeInsets.all(2.0),
        hintStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 12.sp),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 12.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        prefixIcon: icon1,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(2.0),
          child: IconTheme(
            data: const IconThemeData(color: Colors.grey),
            child: IconButton(
              onPressed: click,
              icon: icon,
            ),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white);
  }
  // api calling function
  login(String token) {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {};
      data['email'] = _email.text.trim().toString();
      data['notification_tkn'] = token.toString();
      data['passcode'] = _password.text.trim().toString();
      data['action'] = 'login';
      print('*-*-*-*-*-*-*-*-*-*-* $data *-*-*-*-*-*-*-*-*-*-*-**-*');

      checkInternet().then((internet) async {
        if (internet) {
          authprovider().loginapi(data).then((Response response) async {
            userData = UserModal.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && userData?.status == 1) {
              setState(() {
                // isLoading = false;
              });
              await SaveDataLocal.saveLogInData(userData!);

              // buildErrorDialog(context, "", "Login Successfully");

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const mytrips1()));
            } else {
              buildErrorDialog(
                  context, "Login Error", (userData?.message).toString());
            }
          });
        } else {
          setState(() {
            // isLoading = false;
          });
          buildErrorDialog(context, 'Error', "Internet Required");
        }
      });
    }
  }
  // function for generate firebase token
  Future<String?> setString() async {
    // FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    firebaseMessaging.getToken().then((token) async {
      login(token.toString());
    });
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications(
        );
      }
    });
    return null;
  }
}
