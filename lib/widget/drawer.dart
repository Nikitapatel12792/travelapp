import 'dart:convert';
import 'dart:io';
import 'package:escapingplan/Modal/logoutmodal.dart';
import 'package:escapingplan/Modal/viewmodel.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/screen/MessagePage.dart';
import 'package:escapingplan/screen/login.dart';
import 'package:escapingplan/screen/myagent.dart';
import 'package:escapingplan/screen/mytrips1.dart';
import 'package:escapingplan/screen/ourpartners.dart';
import 'package:escapingplan/screen/profile2.dart';
import 'package:escapingplan/screen/resuestlist.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/locwig.dart';
import 'package:escapingplan/widget/sharedpreferance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
class drawer1 extends StatefulWidget {
  final BuildContext context;
  const drawer1(this.context, {Key? key}) : super(key: key);
  @override
  State<drawer1> createState() => _drawer1State();
}

class _drawer1State extends State<drawer1> {
  List<bool> index = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  ViewModel? viewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view();
    index = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];

  }
  LogoutModal? logoutmodal;
  @override
  Widget build(BuildContext context) {
    double widthDrawer = Platform.isAndroid?MediaQuery.of(context).size.width * 0.75:MediaQuery.of(context).size.width * 0.80;
    return Drawer(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: widthDrawer,
          // color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Container(
                    height: 20.h,
                    padding: EdgeInsets.only(top: 8.h,left: 5.w),
                    width: widthDrawer,
                    // color: Colors.black.withOpacity(0.3),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/escape.jpg"))
                      // image: NetworkImage(
                      //     'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                    ),
                  ),
                  Container(
                    height: 20.h,
                    padding: EdgeInsets.only(top: 8.h,left: 5.w),
                    width: widthDrawer,
                    // color: Colors.black.withOpacity(0.3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),

                      // image: NetworkImage(
                      //     'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                    ),
                    child: (userData != null)
                        ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                               (userData?.data?[0].fullname != null) ? (userData?.data?[0].fullname).toString() :"",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text((userData?.data?[0].email).toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ),
                ],
              ),

              // Divider(color: Colors.black,),

              // Divider(color: Colors.black,),
              Container(
                color: index[1]
                    ? const Color(0xffb4776e6).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: Color(0xffb4776e6),
                    color: index[1] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  leading: Icon(Icons.travel_explore,
                      // color: Color(0xffb4776e6),
                      color: index[1] ? const Color(0xffb4776e6) : Colors.black),
                  title: Text(
                    'My Itinerary',
                    style: TextStyle(
                        // color: Color(0xffb4776e6),
                        color: index[1] ? const Color(0xffb4776e6) : Colors.black,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    setState(() {
                      index[1] = !index[1];
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const mytrips1()));
                  },
                ),
              ),
              Container(
                color: index[2]
                    ? const Color(0xffb4776e6).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: Color(0xffb4776e6),
                    color: index[2] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  leading: Icon(Icons.person,
                      // color: Color(0xffb4776e6),
                      color: index[2] ? const Color(0xffb4776e6) : Colors.black),
                  title: Text(
                    'My Agent',
                    style: TextStyle(
                        // color: Color(0xffb4776e6),
                        color: index[2] ? const Color(0xffb4776e6) : Colors.black,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    setState(() {
                      index[2] = !index[2];
                    });
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Myagent()));
                  },
                ),
              ),
              Container(
                color: index[5]
                    ? const Color(0xffb4776e6).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: Color(0xffb4776e6),
                    color: index[5] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  leading: Icon(
                    Icons.chat,
                    // color: Color(0xffb4776e6),
                    color: index[5] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  title: Text(
                    'Chat with my Agent ',
                    style: TextStyle(
                      // color: Color(0xffb4776e6),
                        color: index[5] ? const Color(0xffb4776e6) : Colors.black,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    setState(() {
                      index[5] = !index[5];
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const MessagePage()));
                  },
                ),
              ),
              Container(
                color: index[4]
                    ? const Color(0xffb4776e6).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: Color(0xffb4776e6),
                    color: index[4] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  leading: Icon(
                    Icons.person,
                    // color: Color(0xffb4776e6),
                    color: index[4] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  title: Text(
                    ' Profile & Invoice',
                    style: TextStyle(
                        // color: Color(0xffb4776e6),
                        color: index[4] ? const Color(0xffb4776e6) : Colors.black,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    setState(() {
                      index[4] = !index[4];
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const profile2()));
                  },
                ),
              ),
              Container(
                color: index[7]
                    ? const Color(0xffb4776e6).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: Color(0xffb4776e6),
                    color: index[7] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  leading: Icon(
                    Icons.people,
                    // color: Color(0xffb4776e6),
                    color: index[7] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  title: Text(
                    'Our Partners',
                    style: TextStyle(
                        // color: Color(0xffb4776e6),
                        color: index[7] ? const Color(0xffb4776e6) : Colors.black,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    setState(() {
                      index[7] = !index[7];
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OurPartners(),
                    ));
                  },
                ),
              ),
              Container(
                color: index[8]
                    ? const Color(0xffb4776e6).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    // color: Color(0xffb4776e6),
                    color: index[8] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  leading: Icon(
                    Icons.location_on,
                    // color: Color(0xffb4776e6),
                    color: index[8] ? const Color(0xffb4776e6) : Colors.black,
                  ),
                  title: Text(
                    'Book Your Next Trip',
                    style: TextStyle(
                        // color: Color(0xffb4776e6),
                        color: index[8] ? const Color(0xffb4776e6) : Colors.black,
                        fontSize: 12.sp,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    setState(() {
                      index[8] = !index[8];
                    });
                    Navigator.of(context).pop();
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>locview(data:"https://www.escapingsolo.com",sta : 0)));
                  },
                ),
              ),
              Container(
                color: index[0]
                    ? const Color.fromARGB(250, 230, 71, 71).withOpacity(0.2)
                    : Colors.transparent,
                child: ListTile(
                  // trailing: Icon(
                  //   Icons.arrow_forward_ios,
                  //   // color: Color(0xffb4776e6),
                  //   color: index[0] ? Color(0xffb4776e6) : Colors.black,
                  // ),
                  leading: Icon(
                    Icons.login,
                    // color: Color(0xffb4776e6),
                    color: index[0]
                        ? const Color.fromARGB(250, 230, 71, 71)
                        : const Color.fromARGB(250, 230, 71, 71),
                  ),
                  title: Text((userData == null) ? 'Login' : 'Logout',
                      style: TextStyle(
                          // color: Color(0xffb4776e6),
                          color: index[0]
                              ? const Color.fromARGB(250, 230, 71, 71)
                              : const Color.fromARGB(250, 230, 71, 71),
                          fontSize: 12.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600)),
                  onTap: () async {
                    setState(() {
                      index[0] = !index[0];
                    });
                    userData == null
                        ? await SaveDataLocal.getDataFromLocal()
                        : logoutapi();
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          )),
    );
  }

  TextStyle textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12.sp,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600);
  view() {
    final Map<String, String> data = {};
    data['action'] = "view_profile";
    data['user_id'] = (userData?.data?[0].uId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewapi(data).then((Response response) async {
          viewmodel = ViewModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && viewmodel?.status == "1") {
            setState(() {
              // isLoading = false;
            });

            if (kDebugMode) {}
          } else {}
        });
      } else {
        setState(() {
          // isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }
  logoutapi(){
    final Map<String, String> data = {};
    data['action'] = "log_out";
    data['user_id'] = (userData?.data?[0].uId).toString();
    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().logoutap(data).then((Response response) async {
           logoutmodal = LogoutModal.fromJson(json.decode(response.body));
          print(logoutmodal?.status);
          if (response.statusCode == 200 && logoutmodal?.status == 1) {

          await SaveDataLocal.clearUserData();

            // Navigator.of(context).pop();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const login1()));

            setState(() {
              // isLoading = false;
            });

            if (kDebugMode) {}
          } else {}
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
