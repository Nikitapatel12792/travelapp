import 'dart:convert';
import 'package:escapingplan/Modal/viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';
import '../Modal/ProfileModel.dart';
import '../Provider/authprovider.dart';
import 'buildErrorDialog.dart';
import 'const.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});
  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  final TextEditingController _user = TextEditingController(text: "");
  final TextEditingController _gen = TextEditingController(text: "");

  final TextEditingController _email = TextEditingController(text: "");
  final TextEditingController _phone = TextEditingController(text: "");
  final TextEditingController _add = TextEditingController(text: "");
  final TextEditingController _date = TextEditingController(text: "");
  ViewModel? viewdata;
  ProfileModel? profilemodel;
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agentapi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
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
                    controller: _user,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Name";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hinttext: (viewdata?.data?.fullName == null)
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
                        hinttext: (viewdata?.data?.emailAddress == null)
                            ? "Email"
                            : _email.text,
                        lable: "Email Address",
                        icon: const Icon(Icons.email_outlined)),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextFormField(
                      controller: _date,
                      readOnly: true,
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Select Birthdate";
                        }
                        return null;
                      },
                      onTap: null,
                      decoration: inputDecoration(
                          icon: const Icon(Icons.date_range),
                          lable: "Date of Birth",
                          hinttext: (viewdata?.data?.dateOfBirth == null)
                              ? "Date of Birth"
                              : _date.text)),
                  SizedBox(
                    height: 4.h,
                  ),
                  IntlPhoneField(
                    readOnly: true,
                    controller: _phone,
                    decoration: inputDecoration(
                        lable: "Phone Number",
                        icon: const Icon(null),
                        hinttext: (viewdata?.data?.phoneNumber == null)
                            ? "Phone Number"
                            : _phone.text),

                    validator: (value) {
                      if (value?.number.length != 10) {
                        return "Enter 10 digit Mobile Number";
                      } else if (value!.number.isEmpty) {
                        return "Enter the  Mobile Number";
                      }
                      return null;
                    },

                    showCountryFlag: false,
                    disableLengthCheck: true,
                    initialCountryCode: "GB",
                    showDropdownIcon: false,
                    // dropdownIconPosition: IconPosition.trailing,
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _gen,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Give Gender";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hinttext: (viewdata?.data?.gender == null)
                            ? "Gender"
                            : _gen.text,
                        lable: "Gender",
                        icon: const Icon(Icons.person)),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: _add,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the Address";
                      }
                      return null;
                    },
                    decoration: inputDecoration(
                        hinttext: (viewdata?.data?.address == null)
                            ? "Address"
                            : _add.text,
                        lable: "Address",
                        icon: const Icon(Icons.home)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
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
  agentapi() {
    final Map<String, String> data = {};
    data['user_id'] = userData?.data?[0].uId ?? "";
    data['action'] = 'view_profile';
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewapi(data).then((Response response) async {
          viewdata = ViewModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && viewdata?.status == 1) {
            setState(() {
              isLoading = false;
              _user.text = (viewdata?.data?.fullName) ?? "";
              _email.text = (viewdata?.data?.emailAddress) ?? "";
              _phone.text = (viewdata?.data?.phoneNumber) ?? "";
              _add.text = (viewdata?.data?.address) ?? "";

              _gen.text = (viewdata?.data?.gender) ?? "";
              _date.text = (viewdata?.data?.dateOfBirth) ?? "";
            });

            if (kDebugMode) {}
          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '', "No profile Data");
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
  // profile() {
  //   final Map<String, String> data = {};
  //   data['user_id'] = ' ${userData?.data?.uId}';
  //   data['action'] = 'view_profile';
  //   print(' ${userData?.data?.uId}' + '================================');
  //   checkInternet().then((internet) async {
  //     if (internet) {
  //       authprovider().viewapi(data).then((Response response) async {
  //         viewdata = ViewModel.fromJson(json.decode(response.body));
  //         if (response.statusCode == 200 && viewdata?.status == 1) {
  //           setState(() {
  //             isLoading = false;
  //             _user.text = viewdata!.data!.fullname ?? "";
  //             _email.text = (viewdata?.data?.email) ?? "";
  //             _phone.text = (viewdata?.data?.phoneno) ?? "";
  //             _add.text = (viewdata?.data?.address) ?? "";
  //
  //             _gen.text = (viewdata?.data?.gender) ?? "";
  //             _date.text = (viewdata?.data?.dateOfBirth) ?? "";
  //           });
  //
  //           if (kDebugMode) {}
  //         } else {
  //           setState(() {
  //             isLoading = false;
  //           });
  //           buildErrorDialog(context, '', "No Agent Data");
  //         }
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       buildErrorDialog(context, 'Error', "Internate Required");
  //     }
  //   });
  // }
// view() {
//   final Map<String, String> data = {};
//   data['action'] = "view_profile";
//   data['user_id'] = (userData?.data?.uId).toString();
//   checkInternet().then((internet) async {
//     if (internet) {
//       authprovider().viewapi(data).then((Response response) async {
//         viewmodel = ViewModel.fromJson(json.decode(response.body));
//         if (response.statusCode == 200 && viewmodel?.status == "1") {
//           setState(() {
//             // isLoading = false;
//           });
//           // await SaveDataLocal.saveLogInData(userData!);
//           _user.text = viewmodel?.data?.fullname ?? "";
//           _email.text = (viewmodel?.data?.email) ?? "";
//           _phone.text = (viewmodel?.data?.phoneno) ?? "";
//           _add.text = (viewmodel?.data?.address) ?? "";
//           _expertise.text = (viewmodel?.data?.expertise) ?? "";
//           _emergency_contact.text = (viewmodel?.data?.emergencyContact) ?? "";
//           _additionaltravel.text =
//               (viewmodel?.data?.additionalTraveller) ?? "";
//           _date.text = (viewmodel?.data?.dateOfBirth) ?? "";
//           // await SaveDataLocal.getDataFromLocal(userData!);
//           if (kDebugMode) {}
//           // buildErrorDialog(context, "","Login Successfully");
//           //
//           //
//           // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>login()));
//         } else {
//           // buildErrorDialog(context, "","Invalid login");
//         }
//       });
//     } else {
//       setState(() {
//         // isLoading = false;
//       });
//       buildErrorDialog(context, 'Error', "Internate Required");
//     }
//   });
// }
}
