import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:escapingplan/Modal/messagemodel.dart';
import 'package:escapingplan/Modal/statusreadmoda.dart';
import 'package:escapingplan/Modal/viewmodel.dart';
import 'package:escapingplan/Provider/authprovider.dart';
import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/screen/mytrips1.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/load.dart';
import 'package:escapingplan/widget/openimage.dart';
import 'package:escapingplan/widget/pdfview.dart';
import 'package:escapingplan/widget/video.dart';
import 'package:escapingplan/widget/videoplayer.dart';
import 'package:escapingplan/widget/webview.dart';
import 'package:escapingplan/widget/webview2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import 'dart:core';

class MessagePage extends StatefulWidget {
  const MessagePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Position? _currentPosition;
  final TextEditingController _chat = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _pickedFile;
  bool isLoading = true;
  LocationPermission? permission;
  String? date;
  String? location;
  String? pdfFlePath;
  String? googleMapsUrl;
  String? _currentAddress;
  var senderid;
  var receiverid;
  var outputDate2 = "";
  var outputDate1;
  String? date2 = "";
  String? data1;
  int? diff;
  String? type;
  final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';
  final ScrollController _scrollController = ScrollController();
  bool emojiShowing = false;
  int? count = 0;
  ViewModel? viewmodel;
  MessageModal? messagemodel;
  Future<void> Counter() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      diff;
      outputDate1;
    });
  }
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      senderid = userData?.data?[0].uId;
      receiverid = userData?.data?[0].clientId;
    });
    viewchat();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      viewchat();
      ststusreadap();
    });
    view();
  }

  @override
  void dispose() {
    _timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  // main ui
  design(){
    return commanScreen(
      scaffold: Scaffold(
          backgroundColor: Colors.transparent,
          body: isLoading
              ? Container()
              : Container(
            height: double.infinity.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              // color: Colors.black.withOpacity(0.7),
              image: DecorationImage(
                  image: const AssetImage("assets/escape.jpg"),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.srcOver,
                  ),
                  fit: BoxFit.cover),
            ),
            child:
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.5.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
                      color:Colors.transparent,
                      height: 8.h,
                      width:MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Platform.isAndroid?const SizedBox(): SizedBox(width: 5.w,),
                          GestureDetector(
                            onTap: (){
                              _timer?.cancel();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const mytrips1()));
                            },
                            child: Icon(Icons.arrow_back_ios,size: 20.sp,color:Colors.white),
                          ),
                          SizedBox(width: 25.w,),
                          Text(
                            userData?.data?[0].clientName ?? "",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 80.5.h,
                        child: ((messagemodel?.data?.length ?? 0) == 0)
                            ? const SizedBox(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              // Center(
                              //     child: CircularProgressIndicator(
                              //       color:Colors.black
                              //     )
                              Center(
                                child: Text(
                                  'No Message ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              ),
                              // SizedBox(height: 1.h,)
                            ],
                          ),
                        )
                            : Stack(
                          children: [
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context)
                                  .size
                                  .height,
                              child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount:
                                messagemodel?.data?.length,
                                itemBuilder: (context, index) {
                                  bool showSeparator = false;

                                  var outputFormat2 =
                                  DateFormat('dd/MM/yyyy');
                                  var outputFormat1 =
                                  DateFormat("dd");
                                  DateTime parseDate = DateFormat(
                                      "dd/MM/yyyy hh:mm:ss")
                                      .parse(messagemodel
                                      ?.data?[index].date ??
                                      "");

                                  if (index <
                                      (messagemodel!.data!.length -
                                          1)) {
                                    var outputFormat2 =
                                    DateFormat('dd/MM/yyyy');
                                    DateTime parseDate1 = DateFormat(
                                        "dd/MM/yyyy hh:mm:ss")
                                        .parse(messagemodel
                                        ?.data?[index + 1]
                                        .date ??
                                        "");
                                    var inputDate1 = DateTime.parse(
                                        parseDate1.toString());
                                    outputDate2 = outputFormat2
                                        .format(inputDate1);
                                  }
                                  var inputDate = DateTime.parse(
                                      parseDate.toString());
                                  var outputFormat =
                                  DateFormat(' hh:mm a');
                                  var outputDate = outputFormat
                                      .format(inputDate);
                                  outputDate1 = outputFormat2
                                      .format(inputDate);
                                  date2 = outputFormat1
                                      .format(inputDate);

                                  diff = (DateTime.now().day) -
                                      int.parse(date2.toString());
                                  Counter();

                                  // outputDate2 = outputFormat2.format(inputDate);
                                  if (outputDate1 != outputDate2) {
                                    showSeparator = true;
                                  } else {
                                    // showSeparator = true;
                                  }
                                  return Column(
                                    children: [
                                      (showSeparator)
                                          ? Column(
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                              margin:
                                              EdgeInsets
                                                  .all(1
                                                  .w),
                                              padding:
                                              EdgeInsets
                                                  .all(1
                                                  .w),
                                              height: 4.h,
                                              width: 25.w,
                                              alignment:
                                              Alignment
                                                  .center,
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    15.0),
                                                color: Colors
                                                    .transparent
                                                    .withOpacity(
                                                    0.3),
                                              ),
                                              child: Text(
                                                (diff == 0)
                                                    ? "Today"
                                                    : (diff ==
                                                    1)
                                                    ? "Yesterday"
                                                    : outputDate1
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize:
                                                    12.sp,
                                                    fontFamily:
                                                    "Poppins"),
                                              )),
                                        ],
                                      )
                                          : Container(),
                                      (senderid ==
                                          messagemodel
                                              ?.data?[index]
                                              .fromUserId)
                                          ? Padding(
                                        padding:
                                        EdgeInsets.only(
                                            left: 35.w,
                                            right: 3.w,
                                            top: 0.h),
                                        child: Container(
                                          // alignment: Alignment
                                          //     .centerLeft,
                                          width:60.w,
                                          margin: EdgeInsets.only(
                                              left: 2.w,
                                              top: 2.h,
                                              right: 2.w),
                                          decoration: BoxDecoration(
                                              color:const Color(0xffb01abc9),
                                              borderRadius: BorderRadius.circular(5.0)
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .end,
                                            children: [
                                              Container(
                                                // height: 30.h,
                                                alignment:Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: (messagemodel
                                                    ?.data?[
                                                index]
                                                    .messageType ==
                                                    "image")
                                                    ? GestureDetector(
                                                    onTap:
                                                        () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              openimage(imageid: messagemodel?.data?[index].message ?? "")));
                                                    },
                                                    child:
                                                    CachedNetworkImage(
                                                      imageUrl: messagemodel?.data?[index].message ?? "",
                                                      placeholder: (context, url) =>
                                                      const Center(
                                                          child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) =>
                                                      const Center(
                                                          child: CircularProgressIndicator()),
                                                      fit: BoxFit.cover,
                                                    )


                                                  // Image
                                                  //     .network(
                                                  //   messagemodel?.data?[index].message ??
                                                  //       "",height:25.h,width:40.h,
                                                  //   fit: BoxFit
                                                  //       .cover,
                                                  // ),
                                                )
                                                    : (messagemodel
                                                    ?.data?[
                                                index]
                                                    .messageType ==
                                                    "video")
                                                    ? GestureDetector(
                                                  onTap:
                                                      () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Player(videoid: messagemodel?.data?[index].message ?? "")));
                                                  },
                                                  child: addVideo(videoid: messagemodel?.data?[index].message.toString()),
                                                )
                                                    : (messagemodel?.data?[index].messageType ==
                                                    "files")
                                                    ? GestureDetector(
                                                  onTap: () async {
                                                    final String? url = (messagemodel?.data?[index].message);
                                                    String fileExtension = path.extension(url!);

                                                    if (fileExtension == ".txt") {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => webview(
                                                            data: messagemodel?.data?[index].message,
                                                          )));
                                                    } else {
                                                      var response = await http.get(Uri.parse((messagemodel?.data?[index].message).toString()));

                                                      String fileName = url.toString().split('/').last;
                                                      Directory? storageDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getDownloadsDirectory();
                                                      String directoryPath = storageDirectory!.path;
                                                      File file = File('$directoryPath/$fileName');
                                                      // Directory directory = await getApplicationDocumentsDirectory();
                                                      await file.writeAsBytes(response.bodyBytes);
                                                      String filePath = '${storageDirectory.path}/$fileName';

                                                      try {

                                                        final result = await OpenFile.open(filePath);
                                                      } catch (e) {
                                                        print(e.toString());
                                                      }
                                                    }
                                                  },
                                                  child: Text(messagemodel?.data?[index].message ?? "", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp)),
                                                )
                                                    : (messagemodel?.data?[index].messageType == "location")
                                                    ? GestureDetector(
                                                  onTap: () async {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => webview2(
                                                          data: messagemodel?.data?[index].message,
                                                        )));

                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                      Text("Tap here", textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp)),
                                                    ],
                                                  ),
                                                )
                                                    : Text(messagemodel?.data?[index].message ?? "", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp)),
                                              ),

                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text(
                                                  outputDate,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey.shade100,
                                                      fontFamily:
                                                      "Poppins",
                                                      fontSize:
                                                      10.sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontStyle:
                                                      FontStyle
                                                          .normal),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 1.w,
                                              // ),
                                              // Image.asset("assets/profile.png",height: 5.w,width: 5.w,fit: BoxFit.cover,),
                                            ],
                                          ),
                                        ),
                                      )
                                          : Padding(
                                        padding:
                                        EdgeInsets.only(
                                            left: 3.w,
                                            top: 1.h,
                                            right: 35.w),
                                        child: Container(

                                          width:60.w,
                                          margin: EdgeInsets.only(
                                              left: 2.w,
                                              top: 2.h,
                                              right: 2.w),
                                          decoration: BoxDecoration(
                                              color:const Color(0xffb909395),
                                              borderRadius: BorderRadius.circular(5.0)
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .end,
                                            children: [
                                              Container(
                                                alignment: Alignment
                                                    .centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: (messagemodel
                                                    ?.data?[
                                                index]
                                                    .messageType ==
                                                    "image")
                                                    ? GestureDetector(
                                                  onTap:
                                                      () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            openimage(imageid: messagemodel?.data?[index].message ?? "")));
                                                  },
                                                  child:
                                                  Image
                                                      .network(
                                                    messagemodel?.data?[index].message ??
                                                        "",height:25.h,width:40.h,
                                                    fit: BoxFit
                                                        .cover,
                                                  ),
                                                )
                                                    : (messagemodel
                                                    ?.data?[
                                                index]
                                                    .messageType ==
                                                    "video")
                                                    ? GestureDetector(
                                                  onTap:
                                                      () {
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Player(videoid: messagemodel?.data?[index].message ?? "")));
                                                  },
                                                  child: addVideo(videoid: messagemodel?.data?[index].message ?? ""),
                                                )
                                                    : (messagemodel?.data?[index].messageType ==
                                                    "files")
                                                    ? GestureDetector(
                                                  onTap: () async {
                                                    final String? url = (messagemodel?.data?[index].message);
                                                    String fileExtension = path.extension(url!);

                                                    if (fileExtension == ".txt") {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (context) => webview(
                                                            data: messagemodel?.data?[index].message,
                                                          )));
                                                    } else {
                                                      var response = await http.get(Uri.parse((messagemodel?.data?[index].message).toString()));
                                                      String fileName = url.toString().split('/').last;
                                                      Directory? storageDirectory = Platform.isAndroid ? await getExternalStorageDirectory() : await getDownloadsDirectory();
                                                      String directoryPath = storageDirectory!.path;
                                                      File file = File('$directoryPath/$fileName');
                                                      // Directory directory = await getApplicationDocumentsDirectory();
                                                      await file.writeAsBytes(response.bodyBytes);
                                                      String filePath = '${storageDirectory.path}/$fileName';

                                                      try {
                                                        final result = await OpenFile.open(filePath);
                                                      } catch (e) {
                                                        print(e.toString());
                                                      }
                                                    }
                                                  },
                                                  child: Text(messagemodel?.data?[index].message ?? "", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp)),
                                                )
                                                    : (messagemodel?.data?[index].messageType == "location")
                                                    ? GestureDetector(
                                                  onTap: () async {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => webview2(
                                                          data: messagemodel?.data?[index].message,
                                                        )));

                                                  },
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                      ),
                                                      Text("Tap here", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp)),
                                                    ],
                                                  ),
                                                )
                                                    : Text(messagemodel?.data?[index].message ?? "", textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 12.sp)),
                                              ),

                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 1.h),
                                                child: Text(
                                                  outputDate,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey.shade100,
                                                      fontFamily:
                                                      "Poppins",
                                                      fontSize:
                                                      10.sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                      fontStyle:
                                                      FontStyle
                                                          .normal),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 1.w,
                                              // ),
                                              // Image.asset("assets/profile.png",height: 5.w,width: 5.w,fit: BoxFit.cover,),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  );
                                },
                                // gridDelegate:
                                //     const SliverGridDelegateWithFixedCrossAxisCount(
                                //         crossAxisCount: 2),
                              ),
                            ),
                            Positioned(
                                top: 0.0,
                                left: 30.w,
                                right: 30.w,
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 3.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(
                                          10.0),
                                      color: Colors.black
                                          .withOpacity(0.3),
                                    ),
                                    child: Text(
                                      (diff == 0)
                                          ? "Today"
                                          : (diff == 1)
                                          ? "Yesterday"
                                          : outputDate1
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: "Poppins"),
                                    ))),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.8.h,),
                    Container(padding: EdgeInsets.only(top: 1.h),
                      height: 7.h,
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.only(bottom: 2.h,top: 2.h,left: 3.w,right: 3.w),
                      color: Colors.white,alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                _showOuterDialog();
                              },
                              child: const Icon(
                                Icons.attach_file_outlined,
                                color: Color(0xff1a54ac),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SizedBox(
                                height: 40.0,
                                width: 300.0,
                                child: TextField(
                                  cursorColor: Colors.black,
                                  style: const TextStyle(fontFamily: "Poppins"),
                                  keyboardType: TextInputType.text,
                                  controller: _chat,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.w),
                                    filled: true,
                                    fillColor:
                                    const Color(0xffb4776e6).withOpacity(0.1),
                                    // border:OutlineInputBorder(
                                    // borderRadius: BorderRadius.circular(20.0)
                                    // ),
                                    hintText: "Type your message....",
                                    hintStyle: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12.sp),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xff1a54ac),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(50.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                        BorderRadius.circular(50.0)),
                                    // suffixIcon: IconButton(
                                    //   icon: Icon(
                                    //     Icons.emoji_emotions_rounded,
                                    //     color: Colors.grey,
                                    //   ),
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       emojiShowing != emojiShowing;
                                    //     });
                                    //   },
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Container(
                            // padding: const EdgeInsets.all(8.0),
                            height: 10.w,
                            width: 10.w,
                            decoration: const BoxDecoration(
                                color: Color(0xff1a54ac),
                                shape: BoxShape.circle),
                            child: IconButton(
                                onPressed: () {
                                  type = "text";
                                  // FocusScope.of(context).unfocus();
                                  addchat();
                                  FocusScopeNode currentFocus = FocusScope.of(context);

                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                icon: Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 6.w,
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 2.w,
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
            // SizedBox(height: 1.h,),
          )),
      isLoading: isLoading,
    );
  }
  @override
  Widget build(BuildContext context) {
    return design();
  }
// api call for send message
  addchat() {
    print(senderid);
    print(receiverid);
    print("djhdjfdf");
    final Map<String, String> data = {};
    data['from_user_id'] = (userData?.data?[0].uId).toString();
    data['to_user_id'] = (userData?.data?[0].clientId).toString();
    data['message_type'] = type.toString();
    data['message'] = (type == "text")
        ? _chat.text.trim()
        : (type == "location")
            ? location ?? ""
            : _pickedFile?.path ?? "";
    data['status'] = "0";
    data['action'] = 'add_chat';

    print(data);
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().addlist(data).then((Response response) async {
          if (response.statusCode == 200) {
            print("kdjmdkfm");
            print(response.body);
            setState(() {
              // isLoading = false;
            });

            viewchat();
            _chat.text = "";

            if (kDebugMode) {}
            // buildErrorDialog(context, "", "Login Successfully");
          } else {
            // buildErrorDialog(context, "", "Invalid login");
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

  view() {
    final Map<String, String> data = {};
    data['action'] = "view_profile";
    data['user_id'] = userData?.data?[0].uId ?? "" ;

    checkInternet().then((internet) async {
      if (internet) {
        authprovider().viewapi(data).then((Response response) async {
          viewmodel = ViewModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && viewmodel?.status == "1") {
            setState(() {
              // isLoading = false;
            });
            // data1 = viewmodel?.data?. ?? "";
          } else {
            // buildErrorDialog(context, "","Invalid login");
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
// api call for view chat
  viewchat() {
    final Map<String, String> data = {};
    data['from_user_id'] = (userData?.data?[0].uId).toString();
    data['to_user_id'] = (userData?.data?[0].clientId).toString();
    data['action'] = 'view_chat';


    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().viewlist(data).then((Response response) async {
          messagemodel = MessageModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && messagemodel?.status == 1) {
            setState(() {
              isLoading = false;
            });

            if (kDebugMode) {}
          } else {
            isLoading = false;
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

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(sampleUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  selectimage() {
    showDialog(
      context: context,
      builder: (context) {
        return
            // Platform.isAndroid
            AlertDialog(
          title: const Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessagePage()));
                    getimagegallery();
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    getimagecamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  selectvideo() {

    showDialog(
      context: context,
      builder: (context) {
        return
            // Platform.isAndroid
            AlertDialog(
          title: const Text("From where do you want to take the Video?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessagePage()));
                    getvideogallery();
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    getvideocamera();
                    Navigator.of(context).pop();
                    // getImage();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getimagecamera() async {
    XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pickedFile = File(photo!.path);
    });
    addchat();
  }

  getvideocamera() async {
    XFile? photo = await _picker.pickVideo(source: ImageSource.camera);
    setState(() {
      _pickedFile = File(photo!.path);
    });
    addchat();
  }

  getvideogallery() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _pickedFile = File(photo!.path);
      print("video daat");
      print(_pickedFile);
    });
    addchat();
  }

  getimagegallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = File(photo!.path);
    });
    addchat();
  }

  getfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        type = "files";
        _pickedFile = File(result.files.single.path.toString());
      });
      addchat();
    } else {
      // User canceled the picker
    }
  }

  getlocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .timeout(const Duration(seconds: 5));
      setState(() {
        _currentPosition = position;


      });
      getaddress();
      return position;
    } catch (e) {
      return null;
    }
  }

  getaddress() async {

    // List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(52.2165157, 6.9437819);

    List<Placemark> placemark = await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude);
    Placemark place = placemark[0];
    setState(() {

      _currentAddress = "${place.locality},${place.postalCode},${place.street}";
    });
  }

  void _showOuterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select from below'),
        content: Container(
          height: 180.0,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 0.0,
                childAspectRatio: 1.3,
                crossAxisCount: 2,
              ),
              children: [
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      type = "video";
                    });

                    // getvideo();
                    Navigator.of(context).pop();
                    selectvideo();
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.lightBlue),
                        child: const Icon(
                          Icons.video_camera_back,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      Text(
                        "video",
                        style:
                            TextStyle(fontSize: 12.sp, fontFamily: "Poppins"),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      type = "image";
                    });
                    Navigator.of(context).pop();
                    selectimage();
                    // XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
                    // setState(() {
                    //   _pickedFile = File(photo!.path);
                    // });
                    // addchat();
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.lightBlue),
                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      Text(
                        "Image",
                        style:
                            TextStyle(fontSize: 12.sp, fontFamily: "Poppins"),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                    bool serviceEnabled = await determinePosition();

                    if (serviceEnabled) {
                      Position? position = await getlocation();
                      location =
                          'https://www.google.com/maps/search/?api=1&query=${position?.latitude},${position?.longitude}';
                      type = "location";
                      addchat();
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.lightBlue),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      const Text("Location"),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    getfile();
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.lightBlue),
                        child: const Icon(
                          Icons.contact_page,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                      const Text("Document"),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
  // api call for status
  ststusreadap(){
    final Map<String, String> data = {};
    data['user_id'] = senderid.toString();
    data['from_user_id'] = receiverid.toString();
    data['action'] = 'messageRead';

      print(data);
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().messagereadapi(data).then((Response response) async {
          StatusreadModal statusread = StatusreadModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && statusread.status == 1) {
            print(statusread.message);
            // setState(() {
            //   isLoading = false;
            // });

            if (kDebugMode) {}
          } else {
            // isLoading = false;
          }
        });
      } else {
        // setState(() {
        //   isLoading = false;
        // });
        buildErrorDialog(context, 'Error', "Internet Required");
      }
    });
  }

}
