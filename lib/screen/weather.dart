import 'dart:convert';

import 'package:escapingplan/Modal/weathermodal.dart';

import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:escapingplan/widget/load.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';



class WeatherPage extends StatefulWidget {
  int? id1;

   WeatherPage({Key? key,this.id1}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherModal? weathermodal;
  bool isLoading = false;
  String? time;
  String? temp;
  int? id = 0;
  String? formattedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather();
    isLoading = true;
    setState(() {
      id= widget.id1;
    });
  }
design(){
    return commanScreen(
      scaffold: Scaffold(
          body: isLoading
              ? Container()
              : Stack(children: [
            Container(
              height: double.infinity.h,
              width: double.infinity.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/escape.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.7),
              // decoration: BoxDecoration(
              //
              //   // image: DecorationImage(
              //   //     fit: BoxFit.fill,
              //   //     image: AssetImage("assets/escape.jpg")),
              //   // sderRadius: BorderRadius.circular(20.0),
              // ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
                    color:Colors.transparent,
                    height: 8.h,
                    width:MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios,color:Colors.white,size: 20.sp,),
                        ),
                        SizedBox(width: 20.w,),
                        Text(
                          "Weather Detail",
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Poppins"),
                        ),
                      ],
                    ),),

                  weathermodal?.data?.length == 1 ? Container(): Container(
                      width:MediaQuery.of(context).size.width,
                      height:5.h,
                      color: Colors.black.withOpacity(0.3),
                      padding: EdgeInsets.only(left: 3.w,right:3.w),
                      child:ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:weathermodal?.data?.length ,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                id =index;
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 28.w,
                                margin: EdgeInsets.only(left: 3.w),
                                padding: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),

                                    border:Border.all( width:2,
                                        color:(id == index) ?Colors.blue: Colors.white)),
                                // ),


                                child:Text(weathermodal?.data?[index].name ?? "",
                                  style: TextStyle(
                                      color: (id == index) ?Colors.blue: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Poppins"
                                  ),)
                            ),
                          );
                        },
                      )
                  ),
                  Container(
                    // color: Colors.red,
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,color:Colors.white),
                      const SizedBox(
                        width: 10,
                      ),
                      Text((weathermodal?.data?[id!].name).toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '⛅',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            time.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            temp.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "${weathermodal?.data?[id!].main?.temp}°",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    (weathermodal?.data?[id!].weather?[0].main).toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 270,
                    width: 370,
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(41, 255, 255, 255),
                      // borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   width: 2.5,
                      //   color: Colors.black,
                      // ),
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2.5,
                        color: const Color(0xff000000),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '🌡️',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${weathermodal?.data?[id!].main?.tempMin}°",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Temprature',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '💨',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      ("${weathermodal?.data?[id!].wind?.speed}Km/h"),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Wind Speed',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '☁',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      (weathermodal?.data?[id!].clouds?.all)
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Clouds',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      '⬆',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      (weathermodal?.data?[id!].wind?.deg)
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Wind degree',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   '------------ More Details ------------',
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   height: 150,
                  //   width: 370,
                  //   decoration: BoxDecoration(
                  //     color: Color.fromARGB(41, 255, 255, 255),
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(
                  //       width: 2.5,
                  //       color: Color(0xff000000),
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'Humidity',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             '💧',
                  //             style: TextStyle(fontSize: 30),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             (weathermodal?.data?.visibility).toString(),
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'Visibility',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             '👁️',
                  //             style: TextStyle(fontSize: 30),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             (weathermodal?.data?.main?.humidity).toString(),
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'Sunrise',
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             '🌤',
                  //             style: TextStyle(fontSize: 30),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             formattedTime.toString(),
                  //             style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ])),
      isLoading: isLoading,
    );
}
  @override
  Widget build(BuildContext context) {
    return design();
  }
  // api call
  weather() {
    final Map<String, String> data = {};
    data['action'] = "weatherforecast";
    data['client_id'] = userData?.data?[0].uId ?? "";
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().weatherapi(data).then((Response response) async {
          weathermodal = WeatherModal.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && weathermodal?.status == 1) {
            var outputFormat2 = DateFormat('dd/MM/yyyy');
            var outputFormat = DateFormat('hh:mm:ss');
            DateTime parseDate = DateFormat("dd-MM-yyyy hh:mm:ss")
                .parse(weathermodal?.time ?? "");
            var inputDate1 = DateTime.parse(parseDate.toString());
            temp = outputFormat.format(inputDate1);
            time = outputFormat2.format(inputDate1);
            int unixTimestamp = (weathermodal?.data?[id!].sys?.sunrise ?? 0);
            DateTime sunriseTime =
                DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);

// Format DateTime object to readable date and time string
            formattedTime = DateFormat('h:mm a').format(sunriseTime);
            print('Sunrise time: $formattedTime');
            setState(() {
              isLoading = false;
              time;
              temp;
              formattedTime;
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
