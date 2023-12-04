import 'dart:convert';
import 'package:escapingplan/Modal/agentmodal.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/screen/MessagePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import '../widget/buildErrorDialog.dart';
import '../widget/const.dart';

class Myagent extends StatefulWidget {
  const Myagent({super.key});

  @override
  State<Myagent> createState() => _MyagentState();
}

class _MyagentState extends State<Myagent> {
  bool isLoading = true;
  final TextEditingController _user = TextEditingController(text: '');
  final TextEditingController _gen = TextEditingController();
  final TextEditingController _email = TextEditingController(text: "");
  final TextEditingController _phone = TextEditingController(text: "");
  final TextEditingController _num = TextEditingController(text: "");
  final TextEditingController _cer = TextEditingController(text: "");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agentapi();
  }
design(){
    return SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      controller: _user,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the Name";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hinttext: (agentdata?.data?.fullname.toString() == "")
                              ? "Name"
                              : _user.text,
                          lable: "Full Name",
                          icon: const Icon(Icons.person)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        String p = "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
                        //Convert string p to a RegEx
                        RegExp regExp = RegExp(p);
                        if (value!.isEmpty) {
                          return 'Please enter Your Email';
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
                          hinttext: (agentdata?.data?.emailAddress.toString() == "")
                              ? "Email"
                              : _email.text,
                          lable: "Email Address",
                          icon: const Icon(Icons.email_outlined)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    // TextFormField(
                    //     controller: _date,
                    //     readOnly: true,
                    //     enabled: true,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return "Select Birthdate";
                    //       }
                    //       return null;
                    //     },
                    //     onTap: null,
                    //     decoration: inputDecoration(
                    //         icon: Icon(Icons.date_range),
                    //         lable: "Date of Birth",
                    //         hinttext: (agentdata?.data?.dateOfBirth == null)
                    //             ? "Date of Birth"
                    //             : _date.text)),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    // IntlPhoneField(
                    //   readOnly: true,
                    //   controller: _phone,
                    //   decoration: inputDecoration(
                    //       lable: "Phone Number",
                    //       icon: Icon(null),
                    //       hinttext: (agentdata?.data?.phoneNumber.toString() == "")
                    //           ? "Phone Number"
                    //           : _phone.text),
                    //
                    //   validator: (value) {
                    //     if (value?.number.length != 10) {
                    //       return "Enter 10 digit Mobile Number";
                    //     } else if (value!.number.isEmpty) {
                    //       return "Enter the  Mobile Number";
                    //     }
                    //     return null;
                    //   },
                    //
                    //   showCountryFlag: false,
                    //   disableLengthCheck: true,
                    //   initialCountryCode: "IN",
                    //   showDropdownIcon: false,
                    //   // dropdownIconPosition: IconPosition.trailing,
                    //   onChanged: (phone) {
                    //     print(phone.completeNumber);
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    // TextFormField(
                    //   readOnly: true,
                    //   controller: _gen,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Give Gender";
                    //     }
                    //     return null;
                    //   },
                    //   decoration: inputDecoration(
                    //       hinttext: (agentdata?.data?.address.toString() == "")
                    //           ? "Gender"
                    //           : _gen.text,
                    //       lable: "Gender",
                    //       icon: Icon(Icons.person)),
                    // ),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    TextFormField(
                      readOnly: true,
                      controller: _num,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter the Address";
                        }
                        return null;
                      },
                      decoration: inputDecoration(
                          hinttext: (agentdata?.data?.aTOLNumber.toString() == "")
                              ? "Atol Number"
                              : _num.text,
                          lable: "Atol Number",
                          icon: const Icon(Icons.numbers)),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    // TextFormField(
                    //   readOnly: true,
                    //   controller: _cer,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Enter the Expertise";
                    //     }
                    //     return null;
                    //   },
                    //   decoration: inputDecoration(
                    //       hinttext: (agentdata?.data?.aTOLCertificate.toString() == "")
                    //           ? "Atol Certificate"
                    //           : _cer.text,
                    //       lable: "Atol Certificate",
                    //       icon: Icon(Icons.file_copy_sharp)),
                    // ),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MessagePage()));
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Live Chat With Agent",style: TextStyle(decoration:TextDecoration.underline,color: Colors.red,fontSize: 12.sp,fontFamily: "Poppins"),
                          ),
                          SizedBox(width: 3.w,),
                          const Icon(Icons.chat,color: Colors.red,)
                        ],
                      ),
                    )
                  ],
                ),

              ),]
        ));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 00,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Agent Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: design(),
    );
  }

  TextStyle textStyle1 = TextStyle(
      fontFamily: "Poppins",
      fontSize: 10.sp,
      color: Colors.grey,
      fontWeight: FontWeight.w400);
  InputDecoration inputDecoration(
      {required String lable, required Icon icon, required String hinttext}) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
      fillColor: Colors.white,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      filled: true,
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      // hintText: "jjhbf",
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(lable),
      ),
      hintText: hinttext,
      hintStyle: textStyle1,
      labelStyle: TextStyle(fontSize: 12.sp, fontFamily: "Poppins"),
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
    );
  }

  // api call
  agentapi() {
    final Map<String, String> data = {};
    data['client_id'] = '${userData?.data?[0].uId}';
    data['action'] = 'my_agent';
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().agentapi(data).then((Response response) async {
          agentdata = MyagentModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && agentdata?.status == 1) {
            setState(() {
              isLoading = false;
              _user.text = agentdata?.data?.fullname ?? "";
              _email.text = (agentdata?.data?.emailAddress) ?? "";
              _phone.text = (agentdata?.data?.phoneNumber) ?? "";
              _num.text = (agentdata?.data?.aTOLNumber) ?? "";
              _cer.text =(agentdata?.data?.aTOLCertificate) ?? "";
              _gen.text = (agentdata?.data?.gender) ?? "";
              // _date.text = (agentdata?.data?.dateOfBirth) ?? "";
            });

            if (kDebugMode) {}
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '', "No Agent Data");
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
}
