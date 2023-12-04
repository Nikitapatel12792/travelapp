import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:escapingplan/Modal/Rrequestmodel.dart';
import 'package:escapingplan/Modal/detailmodel.dart';
import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/screen/MessagePage.dart';
import 'package:escapingplan/screen/mytrips1.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/load.dart';
import 'package:escapingplan/widget/sharedpreferance.dart';
import 'package:escapingplan/widget/video.dart';
import 'package:escapingplan/widget/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class packagedetail extends StatefulWidget {
  final dynamic iid;
  final dynamic trip;

  const packagedetail({Key? key, required this.iid, this.trip}) : super(key: key);

  @override
  State<packagedetail> createState() => _packagedetailState();
}

class _packagedetailState extends State<packagedetail> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _disc = TextEditingController();
  ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  int? _current = 0;
  int? selectindex = -1;
  int? selectindex1 = 0;
  int? group = 0;
  bool? select = false;
  bool? day = false;
  DetailModel? detailmodal;
  bool isLoading = false;
  DateTime? parsedate;
  String? cancledate;
  String? canclecharge;
  String? nonrefund;
  bool tap = true;
  bool tap1 = true;
  bool? set = true;
  bool _isExpanded = false;
  int? len;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    isLoading = true;
    getdata();
    detailap();
  }

  getdata() async {
    userData = await SaveDataLocal.getDataFromLocal();
    setState(() {
      userData;
    });
  }

  final CarouselController _controller = CarouselController();
design(){
  return commanScreen(
    scaffold: Scaffold(
        backgroundColor: Colors.grey.shade100,

        body: isLoading
            ? Container()
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: CarouselSlider(
                      carouselController: _controller,
                      items: (detailmodal?.gallery ?? []).map((item) {
                        return SizedBox(
                          height: 40.h,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: CachedNetworkImage(
                              imageUrl: item ?? '',
                              placeholder: (context, url) =>
                              const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                      'assets/profile_pic_placeholder.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                        height: 40.h,
                        enlargeCenterPage: false,
                        autoPlay: true,
                        // aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                        const Duration(milliseconds: 500),
                        viewportFraction: 1,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5.h,
                    left: 3.w,
                    right: 90.w,
                    child: Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const mytrips1()));
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Positioned(
                    top: 32.h,
                    left: 40.w,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: _current!,
                        count: 3,
                        effect: const ScrollingDotsEffect(
                            spacing: 8.0,
                            radius: 3.0,
                            dotWidth: 8.0,
                            dotHeight: 8.0,
                            paintStyle: PaintingStyle.stroke,
                            strokeWidth: 1.5,
                            dotColor: Colors.white,
                            activeDotColor: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35.h),
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 0.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        // borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    (detailmodal
                                        ?.aboutTheTour?[0].title)
                                        .toString(),
                                    style: TextStyle(
                                      color: const Color(0xffb4776e6),
                                      fontSize: 20.sp,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const MessagePage()));
                                      },
                                      icon: const Icon(
                                        Icons.chat,
                                        color: Color(0xffb4776e6),
                                      )),
                                ),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        dialog();
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color(0xffb4776e6),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),

                            Container(
                              // padding:EdgeInsets.symmetric(
                              //         horizontal: 5.w, vertical:0.0),
                              child: Text(
                                "About your upcoming trip",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 5.w, vertical:0.0),
                              child: Text(
                                (detailmodal
                                    ?.aboutTheTour?[0].description)
                                    .toString(),
                                style: textstyle,
                                maxLines: _isExpanded ? null : 2,
                                overflow: _isExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                            len! < 100 ? Container() : Container(
                              padding:
                              EdgeInsets.only(left: 65.w, right: 0.w),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                child: Container(
                                    child: _isExpanded
                                        ? const Text(
                                      "Read Less",
                                      style: TextStyle(
                                          color: Color(0xffb4776e6),
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                        : const Text("Read More",
                                        style: TextStyle(
                                            color: Color(
                                                0xffb4776e6),
                                            fontWeight:
                                            FontWeight.bold))),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 5.w, vertical:0.0),
                              child: Text(
                                "Important info",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      // detailmodal?.tourInformation?.length == 1 ?Text(""):   Text("Info"  + (index + 1).toString(),style: textstyle1,),
                                      Container(

                                        child: (detailmodal?.aboutTheTour?[0]
                                            .duration == null ||
                                            detailmodal?.aboutTheTour?[0]
                                                .duration == "")
                                            ? Container()
                                            :
                                        Row(
                                          children: [
                                            Text(
                                              "Duration of trip : ",
                                              style: textstyle1,
                                            ),
                                            Text(
                                              (detailmodal?.aboutTheTour?[0]
                                                  .duration)
                                                  .toString(),
                                              style: textstyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      detailmodal
                                          ?.aboutTheTour?[0].startDate ==
                                          "" || detailmodal
                                          ?.aboutTheTour?[0].startDate
                                          .toString() == null ? Container() :
                                      Container(
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 5.w, vertical:2.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Date of departure : ",
                                              style: textstyle1,
                                            ),
                                            Text(
                                              (detailmodal
                                                  ?.aboutTheTour?[0]
                                                  .startDate)
                                                  .toString(),
                                              style: textstyle,
                                            )
                                          ],
                                        ),
                                      ),
                                      detailmodal
                                          ?.aboutTheTour?[0].endDate == "" ||
                                          detailmodal
                                              ?.aboutTheTour?[0].endDate
                                              .toString() == null
                                          ? Container()
                                          :
                                      Container(
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 5.w, vertical:2.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Date of arrival : ",
                                              style: textstyle1,
                                            ),
                                            Text(
                                              (detailmodal
                                                  ?.aboutTheTour?[0].endDate)
                                                  .toString(),
                                              style: textstyle,
                                            )
                                          ],
                                        ),
                                      )
                                    ]
                                )),
                            // SizedBox(
                            //   height: 1.h,
                            // ),
                            // Container(
                            //   // padding:EdgeInsets.symmetric(
                            //   //     horizontal: 5.w, vertical:0.0),
                            //   child: Text(
                            //     "Included",
                            //     style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 14.sp,
                            //       fontFamily: "Poppins",
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 10.h,
                              color: Colors.grey.shade200,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: 20.w,
                                    // color: (group == 0),
                                    decoration: BoxDecoration(
                                      // borderRadius:BorderRadius.circular(10.0),
                                        border: (group == 0)
                                            ? const Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color(
                                                    0xffb4776e6)))
                                            : const Border(
                                            bottom: BorderSide(
                                              width: 0.0,
                                              color:
                                              Colors.transparent,
                                            ))),
                                    child: Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              group = 0;
                                            });
                                          },
                                          icon: Transform.rotate(
                                              angle: 0 * pi / 180,
                                              child: Icon(
                                                Icons.flight,
                                                color:
                                                const Color(0xffb4776e6),
                                                size: 3.h,
                                              )),
                                        ),
                                        Text(
                                          "Flight",
                                          style: textstyle3,
                                        )
                                      ],
                                    ),
                                  ),


                                  Container(
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      // borderRadius:BorderRadius.circular(10.0),
                                        border: (group == 1)
                                            ? const Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color(
                                                    0xffb4776e6)))
                                            : const Border(
                                            bottom: BorderSide(
                                              width: 0.0,
                                              color:
                                              Colors.transparent,
                                            ))),
                                    child: Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              group = 1;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.hotel,
                                            color: const Color(0xffb4776e6),
                                            size: 3.h,
                                          ),
                                        ),
                                        Text(
                                          "Hotels",
                                          style: textstyle3,
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      // borderRadius:BorderRadius.circular(10.0),
                                        border: (group == 2)
                                            ? const Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color(
                                                    0xffb4776e6)))
                                            : const Border(
                                            bottom: BorderSide(
                                              width: 0.0,
                                              color:
                                              Colors.transparent,
                                            ))),
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                group = 2;
                                              });
                                            },
                                            icon: Icon(
                                              Icons
                                                  .calendar_month_outlined,
                                              color: const Color(0xffb4776e6),
                                              size: 3.h,
                                            )),
                                        Text(
                                          "Itinerary",
                                          style: textstyle3,
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: 20.w,
                                    decoration: BoxDecoration(

                                      // borderRadius:BorderRadius.circular(10.0),
                                        border: (group == 3)
                                            ? const Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Color(
                                                    0xffb4776e6)))
                                            : const Border(
                                            bottom: BorderSide(
                                              width: 0.0,
                                              color:
                                              Colors.transparent,
                                            ))),
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                group = 3;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.info_rounded,
                                              color: const Color(0xffb4776e6),
                                              size: 3.h,
                                            )),
                                        Text(
                                          "Other",
                                          style: textstyle3,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: (group == 0)
                                  ? detailmodal!.travelDetail!.isNotEmpty ?
                              (detailmodal
                                  ?.travelDetail?[
                              0]
                                  .departureTime == "" || detailmodal
                                  ?.travelDetail?[
                              0]
                                  .departureTime == null) && (detailmodal
                                  ?.travelDetail?[
                              0]
                                  .dropTime == "" || detailmodal
                                  ?.travelDetail?[
                              0]
                                  .dropTime == null) && (detailmodal
                                  ?.travelDetail?[
                              0]
                                  .departureFromDate == "" || detailmodal
                                  ?.travelDetail?[
                              0]
                                  .departureFromDate == null) && (detailmodal
                                  ?.travelDetail?[
                              0]
                                  .departureToDate == "" || detailmodal
                                  ?.travelDetail?[
                              0]
                                  .departureToDate == null) && (detailmodal
                                  ?.tourInformation?[0].startPoint == "" ||
                                  detailmodal
                                      ?.tourInformation?[0].startPoint ==
                                      null) && (detailmodal
                                  ?.tourInformation?[0].endPoint == "" ||
                                  detailmodal
                                      ?.tourInformation?[0].endPoint ==
                                      null && (detailmodal?.travelDetail?[0]
                                      .returnFromDate == "" || detailmodal
                                      ?.travelDetail?[
                                  0]
                                      .returnFromDate == null) && (detailmodal
                                      ?.travelDetail?[
                                  0]
                                      .returnToDate == "" || detailmodal
                                      ?.travelDetail?[
                                  0]
                                      .returnToDate == null) && (detailmodal
                                      ?.travelDetail?[
                                  0]
                                      .returnDepartureTime == "" ||
                                      detailmodal
                                          ?.travelDetail?[
                                      0]
                                          .returnDepartureTime == null) &&
                                      (detailmodal
                                          ?.travelDetail?[
                                      0]
                                          .returnDropTime == "" || detailmodal
                                          ?.travelDetail?[
                                      0]
                                          .returnDropTime == null) &&
                                      (detailmodal
                                          ?.tourInformation?[0]
                                          .returnStartPoint == "" ||
                                          detailmodal
                                              ?.tourInformation?[0]
                                              .returnStartPoint == null) &&
                                      (detailmodal
                                          ?.tourInformation?[0]
                                          .returnEndPoint == "" || detailmodal
                                          ?.tourInformation?[0]
                                          .returnEndPoint == null)
                              ) ? Center(child: Text(
                                  "No Transfer data available.",
                                  style: textstyle)) :
                              Container(
                                // height:20.h,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                      children: [
                                        ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: detailmodal
                                                ?.travelDetail?.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  // Padding(
                                                  //   padding:EdgeInsets.symmetric(horizontal: 3.w),
                                                  //   child: Text(detailmodal?.travelDetail?.length == 1 ? "": ( ( detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .departureTime == "" || detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .departureTime == null) &&( detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .dropTime == "" || detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .dropTime == null) && ( detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .departureFromDate == "" || detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .departureFromDate == null) && ( detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .departureToDate == "" || detailmodal
                                                  //       ?.travelDetail?[
                                                  //   index]
                                                  //       .departureToDate == null) && ( detailmodal
                                                  //       ?.tourInformation?[index].startPoint == "" || detailmodal
                                                  //       ?.tourInformation?[index].startPoint  == null) && ( detailmodal
                                                  //       ?.tourInformation?[index].endPoint == "" || detailmodal
                                                  //       ?.tourInformation?[index].endPoint  == null) ) ? "":
                                                  //   "Flight detail "+ (index+1).toString(),style: textstyle1,),
                                                  // ),
                                                  // SizedBox(height: 2.h,),
                                                  ((detailmodal
                                                      ?.travelDetail?[
                                                  index]
                                                      .departureTime == "" ||
                                                      detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .departureTime ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .pickupTime == "" ||
                                                          detailmodal
                                                              ?.travelDetail?[
                                                          index]
                                                              .pickupTime ==
                                                              null) &&
                                                      (detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .departureFromDate ==
                                                          "" || detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .departureFromDate ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .departureToDate ==
                                                          "" || detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .departureToDate ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.tourInformation?[index]
                                                          .startPoint == "" ||
                                                          detailmodal
                                                              ?.tourInformation?[index]
                                                              .startPoint ==
                                                              null) &&
                                                      (detailmodal
                                                          ?.tourInformation?[index]
                                                          .endPoint == "" ||
                                                          detailmodal
                                                              ?.tourInformation?[index]
                                                              .endPoint ==
                                                              null)) ?
                                                  Center(
                                                      child: Container()
                                                    // Text(
                                                    //     "No Transfer data available.",style:textstyle),
                                                  ) :
                                                  Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    margin:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 2.w,
                                                        vertical: 1.h),
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 3.w,
                                                        vertical: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10.0),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade600,
                                                          offset: const Offset(
                                                              1.0, 1.0),
                                                          blurRadius: 3.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            // Image.asset("assets/travel/plane.png",height: 12.w,width: 12.w,fit: BoxFit.cover,color: Colors.black,),
                                                            // SizedBox(width: 2.w,),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .departureTime ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .departureTime ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .departureTime)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle1,
                                                                ),
                                                                Text(
                                                                  detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .departureFromDate ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .departureFromDate ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .departureFromDate)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle,
                                                                ),
                                                                Text(
                                                                  detailmodal
                                                                      ?.tourInformation?[
                                                                  index]
                                                                      .startPoint ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.tourInformation?[
                                                                      index]
                                                                          .startPoint ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.tourInformation?[
                                                                  index]
                                                                      .startPoint)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            const Expanded(
                                                              child: Divider(
                                                                  thickness: 1.0,
                                                                  color: Color(
                                                                      0xffb4776e6)
                                                                // height: 30,
                                                              ),
                                                            ),
                                                            Container(
                                                                height: 6.w,
                                                                width: 6.w,
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    2.0),
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: const Color(
                                                                      0xffb4776e6),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                ),
                                                                child: Icon(
                                                                  Icons
                                                                      .flight,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 3.h,
                                                                )),
                                                            const Expanded(
                                                              child: Divider(
                                                                  thickness: 1.0,
                                                                  color: Color(
                                                                      0xffb4776e6)
                                                                // height: 50,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .pickupTime ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .pickupTime ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .pickupTime)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle1,
                                                                ),
                                                                Text(
                                                                  detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .departureToDate ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .departureToDate ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .departureToDate)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle,
                                                                ),
                                                                Text(
                                                                    detailmodal
                                                                        ?.tourInformation?[
                                                                    index]
                                                                        .endPoint ==
                                                                        "" ||
                                                                        detailmodal
                                                                            ?.tourInformation?[
                                                                        index]
                                                                            .endPoint ==
                                                                            null
                                                                        ? ""
                                                                        : (detailmodal
                                                                        ?.tourInformation?[
                                                                    index]
                                                                        .endPoint)
                                                                        .toString(),
                                                                    style:
                                                                    textstyle),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Airlines Name : ",
                                                              style: textstyle1,),
                                                            Text((detailmodal
                                                                ?.travelDetail?[index]
                                                                .airlines ==
                                                                null ||
                                                                detailmodal
                                                                    ?.travelDetail?[index]
                                                                    .airlines ==
                                                                    "")
                                                                ? "N/A"
                                                                : (detailmodal
                                                                ?.travelDetail?[index]
                                                                .airlines)
                                                                .toString(),
                                                                style: textstyle),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Flight Number : ",
                                                              style: textstyle1,),
                                                            Text((detailmodal
                                                                ?.travelDetail?[index]
                                                                .flightNo ==
                                                                null ||
                                                                detailmodal
                                                                    ?.travelDetail?[index]
                                                                    .flightNo ==
                                                                    "")
                                                                ? "N/A"
                                                                : (detailmodal
                                                                ?.travelDetail?[index]
                                                                .flightNo)
                                                                .toString(),
                                                                style: textstyle),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 3.h,),
                                                ],
                                              );
                                            }
                                        ),
                                        SizedBox(height: 2.h,),
                                        ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: const ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: detailmodal
                                                ?.travelDetail?.length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  ((detailmodal
                                                      ?.travelDetail?[index]
                                                      .returnFromDate == "" ||
                                                      detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnFromDate ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnToDate ==
                                                          "" || detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnToDate ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnDepartureTime ==
                                                          "" || detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnDepartureTime ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnPickupTime ==
                                                          "" || detailmodal
                                                          ?.travelDetail?[
                                                      index]
                                                          .returnPickupTime ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.tourInformation?[index]
                                                          .returnStartPoint ==
                                                          "" || detailmodal
                                                          ?.tourInformation?[index]
                                                          .returnStartPoint ==
                                                          null) &&
                                                      (detailmodal
                                                          ?.tourInformation?[index]
                                                          .returnEndPoint ==
                                                          "" || detailmodal
                                                          ?.tourInformation?[index]
                                                          .returnEndPoint ==
                                                          null)) ? Center(
                                                      child: Container()
                                                    // Text(
                                                    // "No Return transfer data available.",style:textstyle),
                                                  ) :
                                                  Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    margin:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 2.w,vertical: 1.h),
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 3.w,
                                                        vertical: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10.0),
                                                      boxShadow: <BoxShadow>[
                                                        BoxShadow(
                                                          color: Colors
                                                              .grey.shade600,
                                                          offset: const Offset(
                                                              1.0, 1.0),
                                                          blurRadius: 3.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child:
                                                    Column(
                                                      children: [
                                                        Row(
                                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            // Image.asset("assets/travel/plane.png",height: 12.w,width: 12.w,fit: BoxFit.cover,color: Colors.black,),
                                                            // SizedBox(width: 2.w,),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnDepartureTime ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .returnDepartureTime ==
                                                                          null)
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  0]
                                                                      .returnDepartureTime)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle1,
                                                                ),
                                                                Text(
                                                                  (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnFromDate ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .returnFromDate ==
                                                                          null)
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnFromDate)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle,
                                                                ),
                                                                Text(
                                                                  (detailmodal
                                                                      ?.tourInformation?[
                                                                  index]
                                                                      .returnStartPoint ==
                                                                      " " ||
                                                                      detailmodal
                                                                          ?.tourInformation?[
                                                                      index]
                                                                          .returnStartPoint ==
                                                                          null)
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.tourInformation?[
                                                                  index]
                                                                      .returnStartPoint)
                                                                      .toString()
                                                                  ,
                                                                  style:
                                                                  textstyle,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            const Expanded(
                                                              child: Divider(
                                                                thickness: 1.0,
                                                                color: Color(
                                                                    0xffb4776e6),
                                                                // height: 30,
                                                              ),
                                                            ),
                                                            Column(
                                                              children: [
                                                                Container(
                                                                    height: 6
                                                                        .w,
                                                                    width: 6
                                                                        .w,
                                                                    margin: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        2.0),
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: const Color(
                                                                          0xffb4776e6),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          5.0),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons
                                                                          .flight,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 3
                                                                          .h,
                                                                    )),
                                                                // Row(
                                                                //   children: [
                                                                //     Icon(Icons.watch_later_outlined,color: Colors.grey.shade400,),
                                                                //     Text("2 Hour",style: textstyle,)
                                                                //   ],
                                                                // )
                                                              ],
                                                            ),
                                                            const Expanded(
                                                              child: Divider(
                                                                  thickness: 1.0,
                                                                  color: Color(
                                                                      0xffb4776e6)
                                                                // height: 50,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnPickupTime ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .returnPickupTime ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnPickupTime)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle1,
                                                                ),
                                                                Text(
                                                                  detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnToDate ==
                                                                      " " ||
                                                                      detailmodal
                                                                          ?.travelDetail?[
                                                                      index]
                                                                          .returnToDate ==
                                                                          null
                                                                      ? ""
                                                                      : (detailmodal
                                                                      ?.travelDetail?[
                                                                  index]
                                                                      .returnToDate)
                                                                      .toString(),
                                                                  style:
                                                                  textstyle,
                                                                ),
                                                                Text(
                                                                    detailmodal
                                                                        ?.tourInformation?[
                                                                    index]
                                                                        .returnEndPoint ==
                                                                        "" ||
                                                                        detailmodal
                                                                            ?.tourInformation?[
                                                                        index]
                                                                            .returnEndPoint ==
                                                                            null
                                                                        ? ""
                                                                        : (detailmodal
                                                                        ?.tourInformation?[
                                                                    index]
                                                                        .returnEndPoint)
                                                                        .toString(),
                                                                    style:
                                                                    textstyle),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Airlines Name : ",
                                                              style: textstyle1,),
                                                            Text((detailmodal
                                                                ?.travelDetail?[index]
                                                                .returnAirlines ==
                                                                null ||
                                                                detailmodal
                                                                    ?.travelDetail?[index]
                                                                    .returnAirlines ==
                                                                    "")
                                                                ? "N/A"
                                                                : (detailmodal
                                                                ?.travelDetail?[index]
                                                                .returnAirlines)
                                                                .toString(),
                                                                style: textstyle),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Flight Number : ",
                                                              style: textstyle1,),
                                                            Text((detailmodal
                                                                ?.travelDetail?[index]
                                                                .returnFlightNo ==
                                                                null ||
                                                                detailmodal
                                                                    ?.travelDetail?[index]
                                                                    .returnFlightNo ==
                                                                    "")
                                                                ? "N/A"
                                                                : (detailmodal
                                                                ?.travelDetail?[index]
                                                                .returnFlightNo)
                                                                .toString(),
                                                                style: textstyle),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              );
                                            }

                                        ),
                                      ]
                                  )

                              ) :
                              Center(
                                child: Text(
                                    "No Transfer data available.",
                                    style: textstyle),
                              )
                                  :

                              (group == 1)
                                  ? detailmodal
                              !.hotel!.isNotEmpty ? (detailmodal
                                  ?.hotel?[0].hotelName ==
                                  "")
                                  ? const Center(
                                child: Text(
                                    "No accomodation data available."),
                              )
                                  : SizedBox(
                                height: 40.h,
                                width: MediaQuery
                                    .of(
                                    context)
                                    .size
                                    .width,
                                child:
                                ListView.builder(
                                    scrollDirection:
                                    Axis
                                        .vertical,
                                    itemCount:
                                    detailmodal
                                        ?.hotel
                                        ?.length,
                                    itemBuilder:
                                        (context,
                                        index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left:
                                            2.w, right: 2.w, bottom:
                                        2.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3
                                                .w,
                                            vertical:
                                            1.h),
                                        decoration:
                                        BoxDecoration(
                                          color: Colors
                                              .white,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          boxShadow: <
                                              BoxShadow>[
                                            BoxShadow(
                                              color:
                                              Colors.grey.withOpacity(0.5),
                                              spreadRadius:
                                              3,
                                              blurRadius:
                                              2,
                                              offset:
                                              const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child:
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex:
                                              2,
                                              child:
                                              ClipRRect(
                                                borderRadius: BorderRadius
                                                    .circular(10.0),
                                                child: Image.network(
                                                  (detailmodal?.hotel?[index]
                                                      .hotelImage).toString(),
                                                  height: 20.h,
                                                  width: 30.w,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                              3.w,
                                            ),
                                            Expanded(
                                              flex:
                                              4,
                                              child:
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    (detailmodal
                                                        ?.hotel?[index]
                                                        .hotelName == null ||
                                                        detailmodal
                                                            ?.hotel?[index]
                                                            .hotelName == ""
                                                        ? ""
                                                        : detailmodal
                                                        ?.hotel?[index]
                                                        .hotelName)
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 14.sp),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.holiday_village,
                                                        color: Colors.grey
                                                            .shade700,
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          ((detailmodal
                                                              ?.hotel?[index]
                                                              .hotelType ==
                                                              "" ||
                                                              detailmodal
                                                                  ?.hotel?[index]
                                                                  .hotelType ==
                                                                  null)
                                                              ? "N/A"
                                                              : detailmodal
                                                              ?.hotel?[index]
                                                              .hotelType)
                                                              .toString(),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: textstyle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  detailmodal?.hotel?[index]
                                                      .location == "" ||
                                                      detailmodal
                                                          ?.hotel?[index]
                                                          .location == null
                                                      ? Container()
                                                      :
                                                  Row(
                                                    children: [
                                                      Icon(Icons
                                                          .location_on_outlined,
                                                          color: Colors.grey
                                                              .shade700),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Expanded(child: Text(
                                                          detailmodal
                                                              ?.hotel?[index]
                                                              .location ==
                                                              "" ||
                                                              detailmodal
                                                                  ?.hotel?[index]
                                                                  .location ==
                                                                  null
                                                              ? ""
                                                              : (detailmodal
                                                              ?.hotel?[index]
                                                              .location)
                                                              .toString(),
                                                          style: textstyle)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.date_range,
                                                          color: Colors.grey
                                                              .shade700),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Text(detailmodal
                                                          ?.hotel?[index]
                                                          .noOfNight ==
                                                          null || detailmodal
                                                          ?.hotel?[index]
                                                          .noOfNight == ""
                                                          ? "N/A"
                                                          : "${detailmodal
                                                          ?.hotel?[index]
                                                          .noOfNight} Nights",
                                                          style: textstyle),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ) : const Center(
                                child: Text(
                                    "No accomodation data available."),
                              )
                                  : (group == 2)
                                  ? detailmodal!.itinerary!.isNotEmpty
                                  ? (detailmodal!.itinerary!.isEmpty)
                                  ? const Text(
                                  "Daywise  no itinerary Available")
                                  : ListView.builder(
                                  padding: const EdgeInsets.all(
                                      0.0),
                                  scrollDirection:
                                  Axis.vertical,
                                  physics:
                                  const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: detailmodal
                                      ?.itinerary
                                      ?.length,
                                  itemBuilder: (context,
                                      index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap:
                                              () {
                                            setState(
                                                    () {
                                                  selectindex1 =
                                                      index;
                                                });
                                          },
                                          child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                              height: 6.h,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2.w),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: 1.h),
                                              decoration: BoxDecoration(
                                                color:
                                                Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .shade600,
                                                    offset: const Offset(1.0, 1.0),
                                                    blurRadius: 1.0,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .calendar_month_outlined,
                                                          size: 3.h,
                                                          color: const Color(
                                                              0xffb4776e6),
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Text("Day ${index + 1}  [${detailmodal
                                                            ?.itinerary?[index]
                                                            .date}]",
                                                            style: textstyle1),
                                                      ],
                                                    ),
                                                    (selectindex1 == index)
                                                        ? Transform.rotate(
                                                        angle: -90 * pi / 180,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_back_ios_new_outlined,
                                                          size: 2.h,
                                                        ))
                                                        : Transform.rotate(
                                                        angle: 90 * pi / 180,
                                                        child: Icon(
                                                          Icons
                                                              .arrow_back_ios_new_outlined,
                                                          size: 2.h,
                                                        )),
                                                  ])),
                                        ),
                                        SizedBox(
                                          height:
                                          1.h,
                                        ),
                                        (selectindex1 ==
                                            index)
                                            ? Container(
                                          color:
                                          Colors.white,
                                          padding:
                                          EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 1.5.h),
                                          child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              (detailmodal?.itinerary?[index]
                                                  .daysTitle == "")
                                                  ? Container()
                                                  : Text(detailmodal
                                                  ?.itinerary?[index]
                                                  .daysTitle ?? "",
                                                  textAlign: TextAlign.left,
                                                  maxLines: 4,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight
                                                          .bold)),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  // Expanded(
                                                  //   flex:1,
                                                  //   child: Container(
                                                  //     margin: EdgeInsets.all(5.0),
                                                  //     height: 7.0,
                                                  //     width: 7.0,
                                                  //     decoration: BoxDecoration(
                                                  //         shape: BoxShape.circle,
                                                  //         color: Colors.black
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  (detailmodal
                                                      ?.itinerary?[index]
                                                      .dayDescription == "")
                                                      ? Text(
                                                      "No description available",
                                                      textAlign: TextAlign
                                                          .left,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily: "Poppins",
                                                          fontWeight: FontWeight
                                                              .normal))
                                                      : Expanded(
                                                    child: Html(
                                                      data: detailmodal
                                                          ?.itinerary?[index]
                                                          .dayDescription,
                                                      // set optional parameters
                                                      // defaultTextStyle: TextStyle(fontSize: 16),
                                                      onLinkTap: (url, _, __,
                                                          ___) {
                                                        Navigator.of(context)
                                                            .push(
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    webview(
                                                                        data: url)));
                                                      },
                                                    ),
                                                  )
                                                  // Expanded(
                                                  //   flex:9,
                                                  //   child:isImageOrVideo((detailmodal?.itinerary?[index].dayDescription ?? "" )) == 1?Image.network(detailmodal?.itinerary?[index].dayDescription ?? "",height: 30.h,width: MediaQuery.of(context).size.width,):
                                                  //   isImageOrVideo((detailmodal?.itinerary?[index].dayDescription ?? "" )) == 2?
                                                  //       addVideo(videoid: detailmodal?.itinerary?[index].dayDescription)
                                                  //   :Text((detailmodal?.itinerary?[index].dayDescription != "")?(detailmodal?.itinerary?[index].dayDescription ).toString():"No Description available.",textAlign: TextAlign.left,maxLines: 4,style: textstyle),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ) : Container(),
                                      ],
                                    );
                                  })
                                  :
                              Center(
                                child: Text(
                                    "Daywise  no itinerary Available",
                                    style: textstyle),
                              )
                                  : SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 40.h,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(
                                                            () {
                                                          tap1 = true;
                                                          tap = false;
                                                          selectindex = 10;
                                                        });
                                                  },
                                                  child: Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width,
                                                      height: 6.h,
                                                      margin: EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2.w),
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal: 3.w,
                                                          vertical: 1.h),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                        boxShadow: <
                                                            BoxShadow>[
                                                          BoxShadow(
                                                            color:
                                                            Colors.grey
                                                                .shade600,
                                                            offset:
                                                            const Offset(1.0, 1.0),
                                                            blurRadius:
                                                            3.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Icon(detail[index].icon,color: Color(0xffb4776e6),),
                                                                SizedBox(
                                                                  width: 3.w,
                                                                ),
                                                                Text(
                                                                    "Transport",
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    maxLines: 2,
                                                                    style: textstyle1),
                                                              ],
                                                            ),
                                                            (!tap)
                                                                ? Transform
                                                                .rotate(
                                                                angle: -90 *
                                                                    pi / 180,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back_ios_new_outlined,
                                                                  size: 2.h,
                                                                ))
                                                                : Transform
                                                                .rotate(
                                                                angle: 90 *
                                                                    pi / 180,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back_ios_new_outlined,
                                                                  size: 2.h,
                                                                )),
                                                          ])),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                !tap?
                                                Container(
                                                  // height:(detailmodal?.transport?.length == 0)?5.h:20.h ,
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2.w),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 3.w,
                                                        vertical: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                      boxShadow: <
                                                          BoxShadow>[
                                                        BoxShadow(
                                                          color:
                                                          Colors.grey
                                                              .shade600,
                                                          offset:
                                                          const Offset(1.0, 1.0),
                                                          blurRadius:
                                                          3.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child:
                                                    detailmodal!.transport!.isEmpty ?
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 0.5.h,),
                                                        Text(
                                                            "No Transport detail available.",
                                                            style: textstyle),
                                                        SizedBox(
                                                          height: 0.5.h,),
                                                      ],
                                                    ) : (detailmodal
                                                        ?.transport?[index]
                                                        .transfer == "" ||
                                                        detailmodal
                                                            ?.transport?[index]
                                                            .transfer ==
                                                            null &&
                                                            detailmodal
                                                                ?.transport?[index]
                                                                .returnTransfer ==
                                                                "" ||
                                                        detailmodal
                                                            ?.transport?[index]
                                                            .returnTransfer ==
                                                            null) ? Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 0.5.h,),
                                                        Text(
                                                            "No Transport detail available.",
                                                            style: textstyle),
                                                        SizedBox(
                                                          height: 0.5.h,),
                                                      ],
                                                    ) :
                                                    SizedBox(
                                                      // height:(detailmodal?.transport?.length == 0)?6.h:15.h ,
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets
                                                              .zero,
                                                          itemCount: detailmodal
                                                              ?.transport
                                                              ?.length,
                                                          itemBuilder: (
                                                              context,
                                                              index) {
                                                            return Column(
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .start,
                                                                children: [

                                                                  (detailmodal
                                                                      ?.transport
                                                                      ?.length ==
                                                                      1)
                                                                      ? const Text(
                                                                      "")
                                                                      :
                                                                  (detailmodal
                                                                      ?.transport?[index]
                                                                      .transfer ==
                                                                      "" ||
                                                                      detailmodal
                                                                          ?.transport?[index]
                                                                          .transfer ==
                                                                          null) &&
                                                                      (detailmodal
                                                                          ?.transport?[index]
                                                                          .returnTransfer ==
                                                                          "" ||
                                                                          detailmodal
                                                                              ?.transport?[index]
                                                                              .returnTransfer ==
                                                                              null)
                                                                      ? const Text(
                                                                      "")
                                                                      :
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                          "Transport Detail${index +
                                                                              1}",
                                                                          style: textstyle1),
                                                                      SizedBox(
                                                                        height: 2
                                                                            .h,
                                                                      ),
                                                                    ],
                                                                  ),

                                                                  Container(
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .width,
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        2.w),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        3.w,
                                                                        vertical:
                                                                        1.h),
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          10.0),
                                                                      boxShadow: <
                                                                          BoxShadow>[
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade600,
                                                                          offset: const Offset(
                                                                              1.0,
                                                                              1.0),
                                                                          blurRadius: 3.0,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child: Column(
                                                                      children: [
                                                                        detailmodal
                                                                            ?.transport?[index]
                                                                            .transfer ==
                                                                            null ||
                                                                            detailmodal
                                                                                ?.transport?[index]
                                                                                .transfer ==
                                                                                ""
                                                                            ? Container()
                                                                            : Row(
                                                                          children: [
                                                                            Text(
                                                                              "Transfer vehicle : ",
                                                                              style: textstyle1,),
                                                                            Expanded(
                                                                              child: Text(
                                                                                (detailmodal
                                                                                    ?.transport?[index]
                                                                                    .transfer)
                                                                                    .toString(),
                                                                                maxLines: 2,
                                                                                style: textstyle,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 1
                                                                              .h,
                                                                        ),
                                                                        detailmodal
                                                                            ?.transport?[index]
                                                                            .returnTransfer ==
                                                                            null ||
                                                                            detailmodal
                                                                                ?.transport?[index]
                                                                                .returnTransfer ==
                                                                                ""
                                                                            ? Container()
                                                                            : Row(
                                                                          children: [
                                                                            Text(
                                                                              "Return transfer vehicle : ",
                                                                              style: textstyle1,),
                                                                            Expanded(
                                                                                child: Text(
                                                                                  (detailmodal
                                                                                      ?.transport?[index]
                                                                                      .returnTransfer)
                                                                                      .toString(),
                                                                                  maxLines: 2,
                                                                                  style: textstyle,)),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // ( detailmodal
                                                                  //     ?.travelDetail?[index]
                                                                  //     .returnPickupTime == "" || detailmodal
                                                                  //     ?.travelDetail?[index]
                                                                  //     .returnPickupTime == null &&  detailmodal
                                                                  //     ?.travelDetail?[index]
                                                                  //     .returnDropTime == "" || detailmodal
                                                                  //     ?.travelDetail?[index]
                                                                  //     .returnDropTime == null) ?Container() :Container(
                                                                  //     width:MediaQuery.of(context).size.width,
                                                                  //     margin: EdgeInsets
                                                                  //         .symmetric(
                                                                  //         horizontal:
                                                                  //         2.w),
                                                                  //     padding: EdgeInsets
                                                                  //         .symmetric(
                                                                  //         horizontal:
                                                                  //         3.w,
                                                                  //         vertical:
                                                                  //         1.h),
                                                                  //     decoration:
                                                                  //     BoxDecoration(
                                                                  //       color: Colors.white,
                                                                  //       borderRadius:
                                                                  //       BorderRadius
                                                                  //           .circular(
                                                                  //           10.0),
                                                                  //       boxShadow: <
                                                                  //           BoxShadow>[
                                                                  //         BoxShadow(
                                                                  //           color: Colors
                                                                  //               .grey
                                                                  //               .shade600,
                                                                  //           offset: Offset(
                                                                  //               1.0, 1.0),
                                                                  //           blurRadius: 3.0,
                                                                  //         ),
                                                                  //       ],
                                                                  //     ),
                                                                  //     child:  Row(
                                                                  //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  //       crossAxisAlignment:
                                                                  //       CrossAxisAlignment
                                                                  //           .center,
                                                                  //       children: [
                                                                  //         // Image.asset("assets/travel/car.png",height: 12.w,width: 12.w,fit: BoxFit.cover,color: Colors.black,),
                                                                  //         // SizedBox(width: 3.w,),
                                                                  //         Column(
                                                                  //           crossAxisAlignment:
                                                                  //           CrossAxisAlignment
                                                                  //               .start,
                                                                  //           children: [
                                                                  //             Text(
                                                                  //               detailmodal
                                                                  //                   ?.travelDetail?[index]
                                                                  //                   .returnPickupTime == "" || detailmodal
                                                                  //                   ?.travelDetail?[index]
                                                                  //                   .returnPickupTime == null ?"" : (detailmodal
                                                                  //                   ?.travelDetail?[index]
                                                                  //                   .returnPickupTime)
                                                                  //                   .toString(),
                                                                  //               style:
                                                                  //               textstyle1,
                                                                  //             ),
                                                                  //             // Text("Fri ,28 Feb",style: textstyle,),
                                                                  //             // Text("Xyz road",style: textstyle,),
                                                                  //           ],
                                                                  //         ),
                                                                  //         SizedBox(
                                                                  //           width: 2.w,
                                                                  //         ),
                                                                  //         Expanded(
                                                                  //           child: Divider(
                                                                  //             color: Color(
                                                                  //                 0xffb4776e6),
                                                                  //             thickness:
                                                                  //             1.0,
                                                                  //             // height: 30,
                                                                  //           ),
                                                                  //         ),
                                                                  //         Container(
                                                                  //           height: 6.w,
                                                                  //           width: 7.w,
                                                                  //           margin: EdgeInsets
                                                                  //               .symmetric(
                                                                  //               horizontal:
                                                                  //               2.0),
                                                                  //           padding: EdgeInsets
                                                                  //               .symmetric(
                                                                  //               horizontal:
                                                                  //               2.0),
                                                                  //           decoration:
                                                                  //           BoxDecoration(
                                                                  //             color: Color(
                                                                  //                 0xffb4776e6),
                                                                  //             borderRadius:
                                                                  //             BorderRadius
                                                                  //                 .circular(
                                                                  //                 5.0),
                                                                  //           ),
                                                                  //           child: Transform
                                                                  //               .rotate(
                                                                  //               angle: 0 *
                                                                  //                   pi /
                                                                  //                   180,
                                                                  //               child: Image
                                                                  //                   .asset(
                                                                  //                 "assets/car.png",
                                                                  //                 fit: BoxFit
                                                                  //                     .cover,
                                                                  //                 color:
                                                                  //                 Colors.white,
                                                                  //               )),
                                                                  //         ),
                                                                  //         Expanded(
                                                                  //           child: Divider(
                                                                  //             color: Color(
                                                                  //                 0xffb4776e6),
                                                                  //             thickness:
                                                                  //             1.0,
                                                                  //             // height: 50,
                                                                  //           ),
                                                                  //         ),
                                                                  //
                                                                  //         SizedBox(
                                                                  //           width: 2.w,
                                                                  //         ),
                                                                  //         Column(
                                                                  //           crossAxisAlignment:
                                                                  //           CrossAxisAlignment
                                                                  //               .start,
                                                                  //           children: [
                                                                  //             Text(
                                                                  //               detailmodal
                                                                  //                   ?.travelDetail?[index]
                                                                  //                   .returnDropTime == "" || detailmodal
                                                                  //                   ?.travelDetail?[index]
                                                                  //                   .returnDropTime  == null ? "": (detailmodal
                                                                  //                   ?.travelDetail?[index]
                                                                  //                   .returnDropTime)
                                                                  //                   .toString(),
                                                                  //               style:
                                                                  //               textstyle1,
                                                                  //             ),
                                                                  //             // Text("Tue ,03 Mar",style: textstyle,),
                                                                  //             // Text("Kochi",style: textstyle),
                                                                  //           ],
                                                                  //         )
                                                                  //       ],
                                                                  //     )
                                                                  // ),
                                                                  SizedBox(
                                                                    height: 3
                                                                        .h,
                                                                  ),
                                                                ]
                                                            );
                                                          }
                                                      ),
                                                    )
                                                ) : Container()
                                              ]
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(
                                                            () {
                                                          tap = true;
                                                          tap1 = false;
                                                          selectindex = 11;
                                                        });
                                                  },
                                                  child: Container(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width,
                                                      height: 6.h,
                                                      margin: EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2.w),
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                          horizontal: 3.w,
                                                          vertical: 1.h),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                        boxShadow: <
                                                            BoxShadow>[
                                                          BoxShadow(
                                                            color:
                                                            Colors.grey
                                                                .shade600,
                                                            offset:
                                                            const Offset(1.0, 1.0),
                                                            blurRadius:
                                                            3.0,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Icon(detail[index].icon,color: Color(0xffb4776e6),),
                                                                SizedBox(
                                                                  width: 3.w,
                                                                ),
                                                                Text(
                                                                    "Lagguage Allowance",
                                                                    overflow: TextOverflow
                                                                        .ellipsis,
                                                                    maxLines: 2,
                                                                    style: textstyle1),
                                                              ],
                                                            ),

                                                            (!tap1)
                                                                ? Transform
                                                                .rotate(
                                                                angle: -90 *
                                                                    pi / 180,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back_ios_new_outlined,
                                                                  size: 2.h,
                                                                ))
                                                                : Transform
                                                                .rotate(
                                                                angle: 90 *
                                                                    pi / 180,
                                                                child: Icon(
                                                                  Icons
                                                                      .arrow_back_ios_new_outlined,
                                                                  size: 2.h,
                                                                )),
                                                          ])),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                !tap1?
                                                Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    // height:detailmodal?.luggageDetail?.length == 0 ? 2.h:detailmodal?.luggageDetail?.length == 1 ? 2.h :12.h,
                                                    margin: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 2.w),
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        horizontal: 3.w,
                                                        vertical: 1.h),
                                                    decoration: BoxDecoration(
                                                      color: Colors
                                                          .white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                      boxShadow: <
                                                          BoxShadow>[
                                                        BoxShadow(
                                                          color:
                                                          Colors.grey
                                                              .shade600,
                                                          offset:
                                                          const Offset(1.0, 1.0),
                                                          blurRadius:
                                                          3.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: (detailmodal
                                                    !.luggageDetail!.isEmpty)
                                                        ? Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(height: 1
                                                                .h,),
                                                            Text(
                                                                "No Luggage detail available",
                                                                style: textstyle),
                                                            SizedBox(height: 1
                                                                .h,),
                                                          ],
                                                        ))
                                                        : detailmodal
                                                        ?.luggageDetail?[0]
                                                        .luggage == "" &&
                                                        detailmodal
                                                            ?.luggageDetail?[0]
                                                            .returnLuggage ==
                                                            "" ? Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 0.5.h,),
                                                            Text(
                                                                "No Luggage detail available",
                                                                style: textstyle),
                                                            SizedBox(
                                                              height: 0.5.h,),
                                                          ],
                                                        )) :
                                                    SizedBox(
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width,
                                                      // height:detailmodal?.luggageDetail?.length == 0 ? 2.h :null,
                                                      child: ListView.builder(
                                                          scrollDirection: Axis
                                                              .vertical,
                                                          shrinkWrap: true,
                                                          itemCount: detailmodal
                                                              ?.luggageDetail
                                                              ?.length,
                                                          itemBuilder: (
                                                              context,
                                                              index) {
                                                            return
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex: 1,
                                                                          child: Container(
                                                                            margin: const EdgeInsets
                                                                                .all(
                                                                                5.0),
                                                                            height: 7.0,
                                                                            width: 7.0,
                                                                            decoration: const BoxDecoration(
                                                                                shape: BoxShape
                                                                                    .circle,
                                                                                color: Colors
                                                                                    .black),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex: 9,
                                                                          child: Container(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment
                                                                                    .start,
                                                                                children: [
                                                                                  Text(
                                                                                      (detailmodal
                                                                                          ?.luggageDetail?[index]
                                                                                          .luggage)
                                                                                          .toString(),
                                                                                      style: textstyle),

                                                                                ],
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ]
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex: 1,
                                                                          child: Container(
                                                                            margin: const EdgeInsets
                                                                                .all(
                                                                                5.0),
                                                                            height: 7.0,
                                                                            width: 7.0,
                                                                            decoration: const BoxDecoration(
                                                                                shape: BoxShape
                                                                                    .circle,
                                                                                color: Colors
                                                                                    .black),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex: 9,
                                                                          child: Container(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment
                                                                                    .start,
                                                                                children: [

                                                                                  Text(
                                                                                      (detailmodal
                                                                                          ?.luggageDetail?[index]
                                                                                          .returnLuggage)
                                                                                          .toString(),
                                                                                      style: textstyle),
                                                                                ],
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ]
                                                                  ),
                                                                ],
                                                              );
                                                          }),
                                                    )

                                                ) : Container()
                                              ]
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(

                                            child: ListView.builder(
                                                padding: const EdgeInsets.all(
                                                    0.0),
                                                scrollDirection:
                                                Axis.vertical,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: detailmodal
                                                    ?.otherInformation
                                                    ?.description
                                                    ?.length,
                                                itemBuilder:
                                                    (context, index) {
                                                  return Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(
                                                                  () {
                                                                tap1 = true;
                                                                tap = true;
                                                                selectindex =
                                                                    index;
                                                              });
                                                        },
                                                        child: Container(
                                                            width: MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width,
                                                            height: 6.h,
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                horizontal: 2
                                                                    .w),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal: 3
                                                                    .w,
                                                                vertical: 1
                                                                    .h),
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10.0),
                                                              boxShadow: <
                                                                  BoxShadow>[
                                                                BoxShadow(
                                                                  color:
                                                                  Colors.grey
                                                                      .shade600,
                                                                  offset:
                                                                  const Offset(1.0,
                                                                      1.0),
                                                                  blurRadius:
                                                                  3.0,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      // Icon(detail[index].icon,color: Color(0xffb4776e6),),
                                                                      SizedBox(
                                                                        width: 3
                                                                            .w,
                                                                      ),
                                                                      Text(
                                                                          (detailmodal
                                                                              ?.otherInformation
                                                                              ?.title?[index])
                                                                              .toString(),
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          maxLines: 2,
                                                                          style: textstyle1),
                                                                    ],
                                                                  ),
                                                                  (selectindex ==
                                                                      index)
                                                                      ? Transform
                                                                      .rotate(
                                                                      angle: -90 *
                                                                          pi /
                                                                          180,
                                                                      child: Icon(
                                                                        Icons
                                                                            .arrow_back_ios_new_outlined,
                                                                        size: 2
                                                                            .h,
                                                                      ))
                                                                      : Transform
                                                                      .rotate(
                                                                      angle: 90 *
                                                                          pi /
                                                                          180,
                                                                      child: Icon(
                                                                        Icons
                                                                            .arrow_back_ios_new_outlined,
                                                                        size: 2
                                                                            .h,
                                                                      )),
                                                                ])),
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      (selectindex ==
                                                          index)
                                                          ? Container(
                                                        width: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                            horizontal: 2.w),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal: 3.w,
                                                            vertical: 1.h),
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .white,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10.0),
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                              color:
                                                              Colors.grey
                                                                  .shade600,
                                                              offset:
                                                              const Offset(
                                                                  1.0, 1.0),
                                                              blurRadius:
                                                              3.0,
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                        Column(
                                                          children: [
                                                            (detailmodal
                                                                ?.otherInformation
                                                                ?.title?[index] ==
                                                                "Cancellation")
                                                                ?
                                                            Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: Container(
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                        height: 7.0,
                                                                        width: 7.0,
                                                                        decoration: const BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: Colors
                                                                                .black),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        "Cancellation date : ",
                                                                        style: textstyle1),
                                                                    Expanded(
                                                                        flex: 9,
                                                                        child: Text(
                                                                          cancledate ==
                                                                              ""
                                                                              ? "No Cancellation date available"
                                                                              : cancledate
                                                                              .toString(),
                                                                          style: textstyle,))
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 1
                                                                        .h),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: Container(
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                        height: 7.0,
                                                                        width: 7.0,
                                                                        decoration: const BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: Colors
                                                                                .black),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Cancellation charge : ",
                                                                      style: textstyle1,),
                                                                    Expanded(
                                                                        flex: 9,
                                                                        child: Text(
                                                                          canclecharge ==
                                                                              ""
                                                                              ? "No Cancellation charge available"
                                                                              : canclecharge
                                                                              .toString(),
                                                                          style: textstyle,))
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 1
                                                                        .h),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: Container(
                                                                        margin: const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                        height: 7.0,
                                                                        width: 7.0,
                                                                        decoration: const BoxDecoration(
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            color: Colors
                                                                                .black),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Non refundable date : ",
                                                                      style: textstyle1,),
                                                                    Expanded(
                                                                        flex: 9,
                                                                        child: Text(
                                                                          nonrefund ==
                                                                              ""
                                                                              ? "No Non refundable date available"
                                                                              : nonrefund
                                                                              .toString(),
                                                                          style: textstyle,))
                                                                  ],
                                                                )
                                                              ],
                                                            )
                                                                :
                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Expanded(
                                                                  flex: 0,
                                                                  child: Container(
                                                                    margin: const EdgeInsets
                                                                        .all(
                                                                        5.0),
                                                                    height: 7.0,
                                                                    width: 7.0,
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 9,
                                                                    child: ((detailmodal
                                                                        ?.otherInformation
                                                                        ?.description?[index] ??
                                                                        "") ==
                                                                        "")
                                                                        ? Text(
                                                                        "No ${detailmodal
                                                                            ?.otherInformation
                                                                            ?.title?[index]} detail available.",
                                                                        textAlign: TextAlign
                                                                            .left,
                                                                        maxLines: 4,
                                                                        style: textstyle)
                                                                        :
                                                                    Text(
                                                                        (detailmodal
                                                                            ?.otherInformation
                                                                            ?.description?[index])
                                                                            .toString(),
                                                                        textAlign: TextAlign
                                                                            .left,
                                                                        maxLines: null,
                                                                        style: textstyle)
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 1.h,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                          : Container(),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),

                                        ],
                                      );
                                    }

                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
    isLoading: isLoading,
  );
}
  @override
  Widget build(BuildContext context) {
    return design();
  }

  TextStyle textstyle = TextStyle(
    // height: 10,
      fontSize: 11.sp,
      color: Colors.grey.shade700,
      fontWeight: FontWeight.w400,
      fontFamily: "Poppins");
  TextStyle textstyle1 = TextStyle(
      fontSize: 12.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins");

  TextStyle textstyle3 = TextStyle(
      fontSize: 10.sp,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: "Poppins");

  dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            height: 45.h,
            width: 80.w,
            // padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                Container(
                  height: 45.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                        image: AssetImage("assets/escape.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  height: 45.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // borderRadius: BorderRadius.circular(16),
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [
                              // Icon(Icons.edit,color:Colors.white ,),
                              Text(
                                "Request any changes",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              controller: _title,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your subject';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(2.0),
                                prefixIcon: const Icon(
                                  Icons.add, color: Colors.grey,),
                                filled: true,
                                hintText: "Subject",
                                hintStyle: textstyle,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 3,
                              controller: _disc,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your description';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.symmetric(vertical: 30.0),
                                prefixIcon: Container(
                                    transform: Matrix4.translationValues(
                                        0, -20, 0),
                                    child: const Icon(
                                      Icons.description, color: Colors.grey,)),
                                filled: true,
                                hintText: "Description",
                                hintStyle: textstyle,
                                fillColor: Colors.grey.shade100,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
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
                                    MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20.sp),
                                        )),
                                  ),
                                  onPressed: () {
                                    requestap();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 14.sp,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      // Icon(
                                      //   Icon,
                                      //   color: Colors.grey.shade700,
                                      // )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
// api call for request
  requestap() {
    if (_formKey.currentState!.validate()) {
      final Map<String, String> data = {};
      data['user_id'] = widget.trip.toString();
      data['itinerary_id'] = widget.iid;
      data['action'] = 'request_change';
      data['comment'] = _disc.text.trim().toString();
      data['subject'] = _title.text.trim().toString();

      checkInternet().then((internet) async {
        if (internet) {
          travelprovider().requestapi(data).then((Response response) async {
            RequestModel requestmodel =
            RequestModel.fromJson(json.decode(response.body));

            if (response.statusCode == 200 && requestmodel.status == 1) {
              setState(() {
                // isLoading = false;
              });
              buildErrorDialog1(context, "", (requestmodel.message).toString());
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>packagedetail(iid: widget.iid)));
              _title.text = "";
              _disc.text = "";

              if (kDebugMode) {}
            } else {
              buildErrorDialog(context, "", (requestmodel.message).toString());
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
// api call for detail packege
  detailap() {
    final Map<String, String> data = {};
    data['itinerary_id'] = widget.iid;
    data['action'] = 'detail_page';
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().detailapi(data).then((Response response) async {
          detailmodal = DetailModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && detailmodal?.status == 1) {
            for (int index = 1; index <
                (detailmodal?.otherInformation?.title?.length ?? 0); index ++) {
              if (detailmodal?.otherInformation?.title?[index] ==
                  "Cancellation") {
                String data = (detailmodal?.otherInformation
                    ?.description?[index]).toString();
                List<String> fruits = data.split(",");
                setState(() {
                  isLoading = false;
                  List<String> fruits = data.split(",");
                  cancledate = fruits[0];
                  canclecharge = fruits[1];
                  nonrefund = fruits[2];
                  String? dis = detailmodal
                      ?.aboutTheTour?[0].description.toString();
                  len = dis!.isEmpty ? 0 : dis.length;
                });
              }
            }
          } else {
            setState(() {
              isLoading = false;
            });
            // buildErrorDialog(context, "", "Invalid login");
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
//dialog box
  buildErrorDialog1(BuildContext context, String title, String contant,
      {VoidCallback? callback, String? buttonname}) {
    Widget okButton = GestureDetector(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20.0),
          // color: Color(0xffb4776e6)
        ),
        child: Center(
          child: Text(buttonname ?? 'OK',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffb4776e6),
                  decorationColor: Colors.black,
                  fontFamily: 'poppins')),
        ),
      ),
      onTap: () {
        // if (callback == null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => packagedetail(iid: widget.iid)));
        // } else {

        // }
      },
    );

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 70.w,
              height: (title == "") ? 15.5.h : 19.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  (title != "")
                      ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  )
                      : Container(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 2.h),
                  okButton,
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 70.w,
              height: (title == "") ? 15.5.h : 19.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  (title != "")
                      ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  )
                      : Container(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      children: [
                        SizedBox(height: 1.h),
                        Text(
                          contant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decorationColor: Colors.black,
                              fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  const Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 2.h),
                  okButton,
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    // show the dialog
  }
}
