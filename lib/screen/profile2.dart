import 'dart:io';
import 'package:escapingplan/Modal/ProfileModel.dart';
import 'package:escapingplan/widget/Invoice.dart';
import 'package:escapingplan/widget/extra%20travellers.dart';
import 'package:escapingplan/widget/myprofileage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class profile2 extends StatefulWidget {
  const profile2({Key? key}) : super(key: key);

  @override
  State<profile2> createState() => _profile2State();
}

class _profile2State extends State<profile2> {
  String? id = "0";
  var filename;

  ProfileModel? profilemodel;

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? _pickedFile;
  String gender = "Male";
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
design(){
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(

            bottom:  PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: TabBar(

                // dividerColor: Colors.black,
                labelColor: Colors.black,
                indicatorColor: Colors.black54,
                // labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,color: Colors.black),
                tabs: [

                  SizedBox(
                    // color: Colors.red,
                    height: 10.h,
                    child: Tab(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      // text: "My Profile",
                      child: Center(
                        child: Text(
                          'My Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: 10.h,
                    child: Tab(
                      icon: const Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      // text:'     Extra \n Travellers'
                      child: Center(
                        child: Text(
                          'Extra Travellers',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: 10.h,
                    child: Tab(
                      icon: const Icon(
                        Icons.summarize,
                        color: Colors.black,
                      ),
                      // text: " Invoice \n History",
                      child: Center(
                        child: Text(
                          'Invoice History',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black,fontFamily: "Poppins",fontSize: 12.sp),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 25.w,
                ),
                const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
                // IconButton(onPressed: (){},
                //     icon: Icon(Icons.edit))
              ],
            ),
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SizedBox(
                height: 70.h,
                child: const TabBarView(
                  children: [Mypage(), ExtraTraveller(),Invoice()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
}
  @override
  Widget build(BuildContext context) {
    return design();
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
  alert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: EdgeInsets.all(2.w),
          // title: new Text('Message'),
          content: Container(
            height: 15.h,
            width: 70.w,
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    camera();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera_alt),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Capture Picture form camera ",
                        style: textStyle1,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                const Divider(),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    gallery();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.photo),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "Choose your picture from gallery",
                        style: textStyle1,
                        maxLines: 2,
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
  camera() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedFile = File(photo!.path);
    });
  }
  gallery() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = File(photo!.path);
    });
  }
}
