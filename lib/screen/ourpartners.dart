import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:escapingplan/Modal/partnersmodal.dart';
import 'package:escapingplan/screen/profile2.dart';
import 'package:escapingplan/widget/bottomnav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../Provider/authprovider.dart';
import '../widget/buildErrorDialog.dart';
import '../widget/const.dart';
import '../widget/drawer.dart';
import '../widget/locwig.dart';

class OurPartners extends StatefulWidget {
  const OurPartners({super.key});

  @override
  State<OurPartners> createState() => _OurPartnersState();
}



class _OurPartnersState extends State<OurPartners> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    partnersapi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer1(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const profile2()));
                },
                child: Row(
                  children: [
                    Text(
                      "Hi , ${userData?.data?[0].fullname}  !",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          fontFamily: "Poppins"),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              left:0.0,
              right: 0.0,
              bottom:10.h,

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 3.w),
                      child: Text("Our Partners",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,
                          fontSize: 20.sp
                      ),),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                   Column(
                    children: [
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text("Luggage",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,
                            fontSize: 16.sp
                        ),),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          itemCount: partnerdata?.luggageDetail?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              // height: 18.h,
                              // width: 10.h,
                              child: GestureDetector(
                                onTap: () async {
                                  // String url = partnerdata?.luggageDetail?[index].partnerLink ?? ""
                                  //     .toString();
                                  // if (await canLaunch(url)) {
                                  //   await launch(url);
                                  // } else {
                                  //   throw 'Could not launch $url';
                                  // }
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>locview(data: partnerdata?.luggageDetail?[index].partnerLink,sta:1)));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                          width: 17.h,
                                          child: CachedNetworkImage(
                                            imageUrl:  partnerdata?.luggageDetail?[index].partnerImage ??
                                                '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10.sp),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                    'assets/profile_pic_placeholder copy.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          child: Flexible(
                                            child: Text(
                                              partnerdata?.luggageDetail?[index].partnerName ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: Text(
                                        //     partnerdata?.data?[index].partnerLink ?? '',
                                        //   ),
                                        // ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text("Insurance",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,
                            fontSize: 16.sp
                        ),),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          itemCount: partnerdata?.insuranceDet?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              // height: 18.h,
                              // width: 10.h,
                              child: GestureDetector(
                                onTap: () async {
                                  //   String url =  partnerdata?.insuranceDet?[index].partnerLink ?? ""
                                  //       .toString();
                                  //   if (await canLaunch(url)) {
                                  //     await launch(url);
                                  //   } else {
                                  //     throw 'Could not launch $url';
                                  //   }
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>locview(data: partnerdata?.insuranceDet?[index].partnerLink,sta:1)));

                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                          width: 17.h,
                                          child: CachedNetworkImage(
                                            imageUrl: partnerdata
                                                ?.insuranceDet?[index].partnerImage ??
                                                '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10.sp),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                    'assets/profile_pic_placeholder copy.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          child: Flexible(
                                            child: Text(
                                              partnerdata
                                                  ?.insuranceDet?[index].partnerName ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: Text(
                                        //     partnerdata?.data?[index].partnerLink ?? '',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text("Beauty",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,
                            fontSize: 16.sp
                        ),),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          itemCount: partnerdata?.beautyDetail?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              // height: 18.h,
                              // width: 10.h,
                              child: GestureDetector(
                                onTap: () async {
                                  // String url = partnerdata!.beautyDetail![index].partnerLink
                                  //     .toString();
                                  // if (await canLaunch(url)) {
                                  //   await launch(url);
                                  // } else {
                                  //   throw 'Could not launch $url';
                                  // }
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>locview(data: partnerdata?.beautyDetail?[index].partnerLink,sta:1)));

                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                          width: 17.h,
                                          child: CachedNetworkImage(
                                            imageUrl: partnerdata
                                                ?.beautyDetail?[index].partnerImage ??
                                                '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10.sp),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                    'assets/profile_pic_placeholder copy.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          child: Flexible(
                                            child: Text(
                                              partnerdata
                                                  ?.beautyDetail?[index].partnerName ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: Text(
                                        //     partnerdata?.data?[index].partnerLink ?? '',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text("Swimwear",style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.bold,
                            fontSize: 16.sp
                        ),),
                      ),
                      SizedBox(
                        height: 25.h,
                        child: ListView.builder(
                          itemCount: partnerdata?.swimwearDetail?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              // height: 18.h,
                              // width: 10.h,
                              child: GestureDetector(
                                onTap: () async {
                                  // String url = partnerdata!.swimwearDetail![index].partnerLink
                                  //     .toString();
                                  // if (await canLaunch(url)) {
                                  //   await launch(url);
                                  // } else {
                                  //   throw 'Could not launch $url';
                                  // }
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>locview(data: partnerdata?.swimwearDetail?[index].partnerLink,sta:1)));

                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 16.h,
                                          width: 17.h,
                                          child: CachedNetworkImage(
                                            imageUrl: partnerdata
                                                ?.swimwearDetail?[index].partnerImage ??
                                                '',
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10.sp),
                                                    ),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                CircularProgressIndicator()),
                                            errorWidget: (context, url, error) =>
                                                Image.asset(
                                                    'assets/profile_pic_placeholder copy.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Container(
                                          child: Flexible(
                                            child: Text(
                                              partnerdata
                                                  ?.swimwearDetail?[index].partnerName ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        // Flexible(
                                        //   child: Text(
                                        //     partnerdata?.data?[index].partnerLink ?? '',
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  )

                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.h,
              left:0.w,
              right: 0.w,
              child: SizedBox(
                  height: 13.h,
                  // width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.only(left: 5.w),
                  // decoration: BoxDecoration(
                  //     // gradient: LinearGradient(
                  //     //     begin: Alignment.bottomCenter,
                  //     //     end: Alignment.topCenter,
                  //     //     colors: [
                  //     //       Colors.blue.shade50,
                  //     //       Colors.white,
                  //     //     ]
                  //     // )
                  //
                  //     ),
                  child: const BottomNavigationExample()
              ),
            ),
          ],
        ),

      ),
    );
  }
// api call
  partnersapi() {
    final Map<String, String> data = {};
    data['action'] = "display_partners";

    checkInternet().then((internet) async {
      if (internet) {
        authprovider().partnerapi(data).then((Response response) async {
          partnerdata = Partnersmodal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && partnerdata?.status == "1") {
            setState(() {
              isLoading = false;
            });
            if (kDebugMode) {}
          } else {
            setState(() {
              isLoading = false;
            });
            // buildErrorDialog(context, "","Invalid login");
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
