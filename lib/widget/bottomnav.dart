import 'dart:async';
import 'dart:convert';

import 'package:escapingplan/Modal/notinumbermodal.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/screen/MessagePage.dart';
import 'package:escapingplan/screen/profile2.dart';
import 'package:escapingplan/screen/weather.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';


class BottomNavigationExample extends StatefulWidget {
  const BottomNavigationExample({super.key});

  @override
  State<BottomNavigationExample> createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  var selected=0;
  NotinumberModal? notinumber;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notinumberapi();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 82.0,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          // color: Colors.pinkAccent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(  padding: EdgeInsets.only(right: 1.w),
                child: Column(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const profile2()));
                      setState(() {
                        selected=0;
                      });
                    }, icon: const Icon(Icons.person)),
                    Text("Profile",style: TextStyle(fontFamily: "Poppins",fontSize: 11.sp),)
                  ],
                ),
              ),
              Container(  padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Column(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GoogleMapExample(id1: 0,)));
                      setState(() {
                        selected=1;
                      });
                    }, icon: const Icon(Icons.map_outlined)),
                    Text("Map",style: TextStyle(fontFamily: "Poppins",fontSize: 11.sp),)
                  ],
                ),
              ),
              Container(  padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Column(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WeatherPage(id1:0)));
                      setState(() {
                        selected=2;
                      });
                    }, icon: const Icon(Icons.cloudy_snowing)),
                    Text("Weather",style: TextStyle(fontFamily: "Poppins",fontSize: 11.sp),)
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Column(

                      children: [
                        IconButton(onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MessagePage()));
                          setState(() {
                            selected=3;
                          });
                        }, icon: const Icon(Icons.chat)),
                        Text("Chat",style: TextStyle(fontFamily: "Poppins",fontSize: 11.sp),)
                      ],
                    ),
                  ),
                  notinumber?.status == 1 ?Positioned(
                      left: 8.5.w,
                      bottom: 15.w,
                      child: Container(
                        alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                    ),
                    child: Text((notinumber?.totalNewMsg).toString(),style:TextStyle(fontFamily: "Poppins",fontSize: 8.sp,color: Colors.white)))):Container(),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
  // api call for notification count
  notinumberapi(){
      final Map<String, String> data = {};

      data['action'] = 'checkNewMsg';
      data['user_id'] = userData?.data?[0].uId ?? "";
      print(data);
      checkInternet().then((internet) async {
        if (internet) {
          authprovider().notiberap(data).then((Response response) async {
            notinumber   = NotinumberModal.fromJson(json.decode(response.body));
            print( notinumber?.status);
            if (response.statusCode == 200 && notinumber?.status == 1) {
              print("teszt");
              print(notinumber?.totalNewMsg);
              setState(() {
                // isLoading = false;
              });


              // buildErrorDialog(context, "", "Login Successfully");


            } else {
              print("teszt1");
              print(notinumber?.totalNewMsg);
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
