import 'dart:convert';

import 'package:escapingplan/Modal/extramodal.dart';
import 'package:escapingplan/widget/load.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../Modal/viewmodel.dart';
import '../Provider/authprovider.dart';
import 'buildErrorDialog.dart';
import 'const.dart';

class ExtraTraveller extends StatefulWidget {
  const ExtraTraveller({super.key});

  @override
  State<ExtraTraveller> createState() => _ExtraTravellerState();
}

class _ExtraTravellerState extends State<ExtraTraveller> {
  ViewModel? viewmodel;
  bool isLoading = true;
int? selectindex1 = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      isLoading=true;
    extraapi();
  }
design(){
    return commanScreen(
        scaffold: Scaffold(
            body: isLoading? Container():
            (((extradata?.data?.length ?? 0) == 0)?
            Container(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text("No Extra Traveller data available.",style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12.sp
                        ),)
                    )
                  ],
                )):
            ListView.builder(
                padding: const EdgeInsets.all(
                    0.0),
                scrollDirection:
                Axis.vertical,
                physics:
                const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: extradata?.data?.length,
                itemBuilder: (context,
                    index) {
                  return
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                      margin:EdgeInsets.symmetric(horizontal: 5.w,vertical: 1.h) ,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                        // color: Colors.grey.shade200,
                        color: Colors.white,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          extradata?.data?[index].name == "" ? Container():
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  Text("  Name : " ,style: textStyle1,),
                                  Text((extradata?.data?[index].name).toString() ,style: textStyle2,),
                                  SizedBox(height: 1.h,),
                                ],
                              ),
                            ],
                          ),

                          extradata?.data?[index].email == "" ? Container():
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.email),
                                  Text("  Email : " ,style: textStyle1,),
                                  Text( (extradata?.data?[index].email).toString(),style: textStyle2, ),
                                  SizedBox(height: 1.h,),
                                ],
                              ),
                            ],
                          ),

                          extradata?.data?[index].dob == "" ? Container():
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              Text("  Date Of Birth : " ,style: textStyle1,),
                              Text( (extradata?.data?[index].dob).toString(),style: textStyle2, ),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          extradata?.data?[index].phone == "" ? Container():
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              Text("  Phone Number : " ,style: textStyle1,),
                              Text( (extradata?.data?[index].phone).toString(),style: textStyle2, ),
                            ],
                          ),
                        ],
                      ),
                    );
                }))
          // ListView.builder(
          //       padding: EdgeInsets.all(
          //           0.0),
          //       scrollDirection:
          //       Axis.vertical,
          //       physics:
          //       BouncingScrollPhysics(),
          //       shrinkWrap: true,
          //       itemCount: extradata?.data?.length,
          //       itemBuilder: (context,
          //           index) {
          //         return Column(
          //           children: [
          //             GestureDetector(
          //               onTap:
          //                   () {
          //                 setState(
          //                         () {
          //                       selectindex1 =
          //                           index;
          //                     });
          //                 extraapi();
          //               },
          //               child: Container(
          //                   width: MediaQuery.of(context).size.width,
          //                   height: 6.h,
          //                   margin: EdgeInsets.symmetric(horizontal: 2.w),
          //                   padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius:
          //                     BorderRadius.circular(10.0),
          //                     boxShadow: <BoxShadow>[
          //                       BoxShadow(
          //                         color: Colors.grey.shade600,
          //                         offset: Offset(1.0, 1.0),
          //                         blurRadius: 1.0,
          //                       ),
          //                     ],
          //                   ),
          //                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //                     Row(
          //                       children: [
          //                         Icon(
          //                           Icons.person,
          //                           size: 3.h,
          //                           color: Colors.black,
          //                         ),
          //                         SizedBox(
          //                           width: 3.w,
          //                         ),
          //                         Text("Traveller " + ((index + 1).toString()) , style: textstyle1),
          //                       ],
          //                     ),
          //                     (selectindex1 == index)
          //                         ? Transform.rotate(
          //                         angle: -90 * pi / 180,
          //                         child: Icon(
          //                           Icons.arrow_back_ios_new_outlined,
          //                           size: 2.h,
          //                         ))
          //                         : Transform.rotate(
          //                         angle: 90 * pi / 180,
          //                         child: Icon(
          //                           Icons.arrow_back_ios_new_outlined,
          //                           size: 2.h,
          //                         )),
          //                   ])),
          //             ),
          //             SizedBox(
          //               height:
          //               1.h,
          //             ),
          //             (selectindex1 ==
          //                 index)
          //                 ? Container(
          //               color:
          //               Colors.white,
          //               padding:
          //               EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
          //               child: Container(
          //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
          //                 child: Column(
          //                   children: [
          //                     SizedBox(
          //                       height:
          //                       1.h,
          //                     ),
          //                     TextFormField(
          //                       controller: _user,
          //                       keyboardType: TextInputType.text,
          //                       validator: (value) {
          //                         if (value!.isEmpty) {
          //                           return "Enter the Name";
          //                         }
          //                         return null;
          //                       },
          //                       decoration: inputDecoration(
          //                           hinttext:
          //                           // (extradata?.data?.agent2?.email == null)
          //                           //     ? "Name"
          //                           //     :
          //                           _user.text,
          //                           lable: "Full Name",
          //                           icon: Icon(Icons.person)),
          //                     ),
          //                     SizedBox(
          //                       height: 4.h,
          //                     ),
          //                     TextFormField(
          //                       readOnly: true,
          //                       controller: _email,
          //                       keyboardType: TextInputType.emailAddress,
          //                       validator: (value) {
          //                         String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
          //                             "\\@" +
          //                             "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
          //                             "(" +
          //                             "\\." +
          //                             "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
          //                             ")+";
          //                         //Convert string p to a RegEx
          //                         RegExp regExp = RegExp(p);
          //                         if (value!.isEmpty) {
          //                           return 'Please enter Your Email';
          //                         } else {
          //                           //If email address matches pattern
          //                           if (regExp.hasMatch(value)) {
          //                             return null;
          //                           } else {
          //                             //If it doesn't match
          //                             return 'Email is not valid';
          //                           }
          //                         }
          //                       },
          //                       decoration: inputDecoration(
          //                           hinttext:
          //                           // (extradata?.data?.agent1?.email == null)
          //                           //     ? "Email"
          //                           //     :
          //                           _email.text,
          //                           lable: "Email Address",
          //                           icon: Icon(Icons.email_outlined)),
          //                     ),
          //                     SizedBox(
          //                       height: 4.h,
          //                     ),
          //                     TextFormField(
          //                         controller: _date,
          //                         readOnly: true,
          //                         enabled: true,
          //                         validator: (value) {
          //                           if (value!.isEmpty) {
          //                             return "Select Birthdate";
          //                           }
          //                           return null;
          //                         },
          //                         onTap: null,
          //                         decoration: inputDecoration(
          //                             icon: Icon(Icons.date_range),
          //                             lable: "Date of Birth",
          //                             hinttext: "Date of Birth")),
          //                     SizedBox(
          //                       height: 4.h,
          //                     ),
          //                     IntlPhoneField(
          //                       readOnly: true,
          //                       controller: _phone,
          //                       decoration: inputDecoration(
          //                           lable: "Phone Number",
          //                           icon: Icon(null),
          //                           hinttext:
          //                           // (extradata?.data?.agent1?.phone == null)
          //                           //     ? "Phone Number"
          //                           //     :
          //                           _phone.text),
          //
          //                       validator: (value) {
          //                         if (value?.number.length != 10) {
          //                           return "Enter 10 digit Mobile Number";
          //                         } else if (value!.number.isEmpty) {
          //                           return "Enter the  Mobile Number";
          //                         }
          //                         return null;
          //                       },
          //
          //                       showCountryFlag: false,
          //                       disableLengthCheck: true,
          //                       initialCountryCode: "IN",
          //                       showDropdownIcon: false,
          //                       // dropdownIconPosition: IconPosition.trailing,
          //                       onChanged: (phone) {
          //                         print(phone.completeNumber);
          //                       },
          //                     ),
          //                     SizedBox(
          //                       height:
          //                       1.h,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             )
          //                 : Container(),
          //           ],
          //         );
          //       }),
        ),
        isLoading:isLoading
    );
}
  @override
  Widget build(BuildContext context) {
    return design();
  }

  TextStyle textStyle1 = TextStyle(
      fontFamily: "Poppins",
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600);
  TextStyle textStyle2 = TextStyle(
      fontFamily: "Poppins",
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w400);
  TextStyle textstyle1 = TextStyle(
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins");
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
  extraapi() {
    final Map<String, String> data = {};
    data['id'] = userData?.data?[0].uId ?? "";
    data['action'] = 'extra_traveller';
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().extrapartnerapi(data).then((Response response) async {
          extradata = ExtratravModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && extradata?.status == 1) {
            setState(() {
              isLoading = false;
              // print(extradata?.data?.length);
              // _user.text = (extradata?.data?[selectindex1!].name) ?? "";
              // _email.text = (extradata?.data?[selectindex1!].email) ?? "";
              // _phone.text = (extradata?.data?[selectindex1!].phone) ?? "";
              // _add.text = (extradata?.data?[0].dob) ?? "";

              // _gen.text = (agentdata?.data?.gender) ?? "";
              // _date.text = (extradata?.data?[selectindex1!].dob) ?? "";
            });

            if (kDebugMode) {}
          } else {
            setState(() {
              isLoading = false;
            });
            print('${extradata?.status} ====================================');
            buildErrorDialog(context, '', "No Extra Travellers");
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
