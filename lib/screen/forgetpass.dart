import 'dart:convert';
import 'package:escapingplan/Modal/forgetpassmodal.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
class forgetpass extends StatefulWidget {
  const forgetpass({Key? key}) : super(key: key);
  @override
  State<forgetpass> createState() => _forgetpassState();
}
class _forgetpassState extends State<forgetpass> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final TextEditingController _email =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  forgetpassmodal? forgetpass;

  // main ui function
  design(){
    return Stack(children: [
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/splash2.jpg",
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
          title:Text("Forgot Password",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.sp,
                fontFamily: "Poppins"),
            textAlign: TextAlign.left,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          centerTitle: true,
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
                          return 'Please enter the email';
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
                        onPressed: () {
                          forget();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Send Email",
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 2.w,),
                            Icon(Icons.email_outlined,size: 14.sp,color: Colors.grey.shade700,)
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
    return design();
  }
  InputDecoration inputDecoration(
      {required Icon icon1,
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
  //api call forgetpass
  forget(){
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {
      };
      data['email'] = _email.text.trim().toString();
      data['action'] = 'forget_password';
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().loginapi(data).then((Response response) async {
            forgetpass = forgetpassmodal.fromJson(json.decode(response.body));
            print(forgetpass?.status);
            if (response.statusCode == 200 && forgetpass?.status == "1") {
              setState(() {
                // isLoading = false;
              });

              print(forgetpass?.message);
              // SharedPreferences pref = await SharedPreferences.getInstance();
              // pref.setString("id", (userData?.data?.uId).toString());
              // await SaveDataLocal.getDataFromLocal(userData!);
              if (kDebugMode) {
              }
              buildErrorDialog(context, "",(forgetpass?.message).toString());


              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>newpage()));
            }
            else{
              buildErrorDialog(context, "","Invalid login");
            }
          });

        } else {
          setState(() {
            // isLoading = false;
          });
          buildErrorDialog(context, 'Error',"Internate Required");
        }
      });
    }
  }
}
