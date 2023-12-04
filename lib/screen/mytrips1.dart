import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:escapingplan/Modal/Favouritemodal.dart';
import 'package:escapingplan/Modal/tripmodel.dart';
import 'package:escapingplan/Modal/viewmodel.dart';
import 'package:escapingplan/Modal/weathermodal.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/screen/MessagePage.dart';
import 'package:escapingplan/screen/login.dart';
import 'package:escapingplan/screen/packegedetail.dart';
import 'package:escapingplan/screen/profile2.dart';
import 'package:escapingplan/screen/weather.dart';
import 'package:escapingplan/widget/bottomnav.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/drawer.dart';
import 'package:escapingplan/widget/load.dart';
import 'package:escapingplan/widget/location.dart';
import 'package:escapingplan/widget/sharedpreferance.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
class mytrips1 extends StatefulWidget {
  const mytrips1({
    Key? key,
  }) : super(key: key);

  @override
  State<mytrips1> createState() => _mytrips1State();
}

class _mytrips1State extends State<mytrips1> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? positionString;
  Favouritemodal? favouritemodel;
  ViewModel? viewmodel;
  TripModel? tripmodel;
  int? select;
  List<Location>? placemarks;
  bool isLoading = true;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  int? selectindex = 0;
  int? selectindex1 = 0;
  int? selectindex2 = 0;
  int? selectindex3 = 0;
  WeatherModal? weathermodal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    setupInteractedMessage();
  }
  getdata() async {
    await trip();
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }
  Future<void> setupInteractedMessage() async {

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  RemoteNotification? notification = message.notification;
        var title =  notification?.title.toString();
        var body = notification?.body.toString();

      _handleMessage(message);
      // _handleMessage(message);
      // Handle the received message here
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      var title =  notification?.title.toString();
      var body = notification?.body.toString();
      Platform.isAndroid? AwesomeNotifications().createNotification(
          content: NotificationContent(
            payload: {

              "name": "FlutterCampus", "route": "/chat"
            },
            id: Random().nextInt(100000),
            channelKey: 'alerts',
            title: title,
            icon: body == "Photo" ? "assets/car.png":"assets/cloud.png",
            bigPicture: 'assets/logo.png',
            body: body,
          )):
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            // payload: {
            //
            //   "name": "FlutterCampus", "route": "/chat"
            // },
            id: Random().nextInt(100000),
            channelKey: 'alerts',
            title: title,
            icon: body == "Photo" ? "assets/car.png":"assets/cloud.png",
            bigPicture: 'assets/logo.png',
            body: body,
          ));
      // _handleMessage(message);
      // Handle the received message here
    });
    FirebaseMessaging.onBackgroundMessage((message){
      RemoteNotification? notification = message.notification;
      var title =  notification?.title.toString();
            var body = notification?.body.toString();
      AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    payload: {

                      "name": "FlutterCampus", "route": "/chat"
                    },
                id: Random().nextInt(100000),
                channelKey: 'alerts',
                title: title,
                icon: body == "Photo" ? "assets/car.png":"assets/cloud.png",
                bigPicture: 'assets/logo.png',
                body: body,
              ));
    // _handleMessage(message);

    return Future<void>.value();
    });
  }
  void _handleMessage(RemoteMessage message) {
    String? state;
    state = message.data['action'];
    if (state == 'Chat') {
      state = "";
      (userData == null)
          ? Navigator.push(context,
          MaterialPageRoute(builder: (context) => const login1())) :
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MessagePage()));
    }
    else{
      // Navigator.of(context).pop();
      (userData == null)
          ? Navigator.push(context,
          MaterialPageRoute(builder: (context) => const login1())) :
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const mytrips1()));
    }
  }
design(){
    return commanScreen(
      scaffold: Scaffold(
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
                        "Hi , ${userData?.data?[0].fullname}",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            fontFamily: "Poppins"),
                      ),
                      SizedBox(width: 2.w),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? Container()
            : (tripmodel?.status == 0)
            ? const Center(child: Text("No trip available"))
            : Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 0.0,
                  bottom: 10.h,
                  left: 0.0,
                  right: 0.0,
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          "My itinerary",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                              fontFamily: "Poppins"),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 40.h,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width,
                                  height: 40.h,
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                    tripmodel?.data?.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {

                                            setState(() {
                                              selectindex2 = index;
                                            });
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => packagedetail(
                                                    iid: (tripmodel
                                                        ?.data?[
                                                    index]
                                                        .itineraryId)
                                                        .toString(), trip : (tripmodel?.data?[index].tripplannerId))));
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 40.h,
                                                width: 80.w,
                                                padding: EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    3.w,
                                                    vertical:
                                                    1.h),
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      20.0),
                                                  child:
                                                  CachedNetworkImage(
                                                    imageUrl: (tripmodel?.data?[index].galleryImage ?? ""),
                                                    placeholder: (context,
                                                        url) =>
                                                    const Center(
                                                        child:
                                                        CircularProgressIndicator()),
                                                    errorWidget: (context,
                                                        url,
                                                        error) =>
                                                    // Container(
                                                    //     color: Colors
                                                    //         .white),
                                                    Image.asset('assets/profile_pic_placeholder.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 28.h,
                                                left: 3.w,
                                                right: 3.w,
                                                child: Container(
                                                  alignment: Alignment
                                                      .center,
                                                  height: 8.h,
                                                  // width:74.w,
                                                  color: Colors.black
                                                      .withOpacity(
                                                      0.3),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          (tripmodel
                                                              ?.data?[index]
                                                              .title)
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 20
                                                                  .sp,
                                                              fontFamily:
                                                              "Poppins",
                                                              fontWeight:
                                                              FontWeight.w600),
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          textAlign:
                                                          TextAlign
                                                              .center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onScaleStart:
                                      (ScaleStartDetails details) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GoogleMapExample(
                                                  id1: 0,
                                                )));
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 80.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w,
                                        vertical: 1.h),
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(20.0),
                                      child: GoogleMap(
                                        onTap: (LatLng latLng) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GoogleMapExample(
                                                          id1: 0)));
                                        },
                                        mapType: MapType.normal,
                                        initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                (weathermodal?.data?[0].coord
                                                    ?.lat)
                                                    ?.toDouble() ??
                                                    0.0,
                                                (weathermodal
                                                    ?.data?[0]
                                                    .coord
                                                    ?.lon)
                                                    ?.toDouble() ??
                                                    0.0),
                                            zoom: 3.0),
                                        onMapCreated:
                                            (GoogleMapController
                                        controller) {
                                          _controller
                                              .complete(controller);
                                          setState(() {
                                            Marker(
                                                markerId: const MarkerId("marker_1"),
                                                position: LatLng((weathermodal?.data?[0].coord?.lat)?.toDouble() ?? 0.0 ,(weathermodal?.data?[0].coord?.lon)?.toDouble() ?? 0.0),
                                                infoWindow: const InfoWindow(title: 'Marker 1'),
                                                rotation: 0);
                                          });
                                        },
                                        myLocationEnabled: true,
                                        markers: <Marker>{
                                          Marker(
                                            markerId: const MarkerId("loc"),
                                            position: LatLng(
                                                (weathermodal
                                                    ?.data?[0]
                                                    .coord
                                                    ?.lat)
                                                    ?.toDouble() ??
                                                    0.0,
                                                (weathermodal
                                                    ?.data?[0]
                                                    .coord
                                                    ?.lon)
                                                    ?.toDouble() ??
                                                    0.0),
                                          )
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          WeatherPage(
                                            id1: 0,
                                          ),
                                    ));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        height: 40.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  "assets/escape.jpg")),
                                          border: Border.all(
                                              color: Colors.black),
                                          borderRadius:
                                          BorderRadius.circular(
                                              20.0),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 3.w,
                                            vertical: 1.h),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w),
                                        height: 40.h,
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withOpacity(0.7),
                                          // image: DecorationImage(
                                          //     fit: BoxFit.fill,
                                          //     image: AssetImage("assets/escape.jpg")),
                                          border: Border.all(
                                              color: Colors.black),
                                          borderRadius:
                                          BorderRadius.circular(
                                              20.0),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 3.w,
                                            vertical: 1.h),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                              20.0),
                                          child: Center(
                                              child: weathermodal
                                                  ?.data?[0]
                                                  .main
                                                  ?.temp ==
                                                  null
                                                  ? Container()
                                                  : Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child:
                                                        Text(
                                                          weathermodal?.data?[0].name ??
                                                              "",
                                                          maxLines:
                                                          2,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 17.sp,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '🌡️',
                                                            style:
                                                            TextStyle(
                                                              fontSize: 18.sp,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${(weathermodal?.data?[0].main?.temp)?.toStringAsFixed(2) ?? ""}°",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17.sp,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          const Icon(
                                                            Icons.arrow_forward_ios_rounded,
                                                            color:
                                                            Colors.white,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                      color: Colors
                                                          .grey,
                                                      thickness:
                                                      0.08.h),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Description - ',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white,
                                                            fontSize: 17.sp,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            (weathermodal?.data?[0].weather?[0].main).toString(),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17.sp,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Divider(
                                                      color: Colors
                                                          .grey,
                                                      thickness:
                                                      0.08.h),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Clouds - ',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white,
                                                            fontSize: 17.sp,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            (weathermodal?.data?[0].clouds!.all).toString(),
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17.sp,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          const Text(
                                                            ' ☁',
                                                            style:
                                                            TextStyle(
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ])),
                      SizedBox(
                        height: 2.h,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "Feeling Adventurous?",
                      //         style: TextStyle(
                      //             color: Colors.black,
                      //             fontSize: 18.sp,
                      //             fontFamily: "Poppins",
                      //             fontWeight: FontWeight.w600),
                      //         textAlign: TextAlign.center,
                      //       ),
                      //       TextButton(
                      //           onPressed: () {},
                      //           child: Text(
                      //             "Show all",
                      //             style: TextStyle(
                      //                 color: Color(0xffb4776e6),
                      //                 fontSize: 12.sp,
                      //                 fontFamily: "Poppins",
                      //                 fontWeight: FontWeight.w600),
                      //           ))
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.h,
              left: 0.w,
              right: 0.w,
              child: SizedBox(
                  height: 13.h,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
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
                  child: const BottomNavigationExample()),
            ),
          ],
        ),
      ),
      isLoading: isLoading,
    );
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return design();
  }
//api call
  weatherap() {
    final Map<String, String> data = {};
    data['action'] = "weatherforecast";
    data['client_id'] = userData?.data?[0].uId ?? "";
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().weatherapi(data).then((Response response) async {
          weathermodal = WeatherModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && weathermodal?.status == 1) {
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
//api call
  view() {
    final Map<String, String> data = {};
    data['action'] = "view_profile";
    data['user_id'] = (userData?.data?[0].uId).toString();
    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewapi(data).then((Response response) async {
          viewmodel = ViewModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && viewmodel?.status == 1) {

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
// api call
  trip() {
    final Map<String, String> data = {};
    data['client_id'] = userData?.data?[0].uId ?? "";
    data['type'] = "All";
    data['action'] = 'my_trip';
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().tripapi(data).then((Response response) async {
          tripmodel = TripModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && tripmodel?.status == 1) {
            weatherap();
            view();
            setState(() {
              isLoading = false;
            });


          } else {
            setState(() {
              isLoading = false;
            });
            buildErrorDialog(context, '',"No Itinerary");
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
