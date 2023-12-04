
import 'dart:convert';


import 'package:escapingplan/Modal/weathermodal.dart';
import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';




class GoogleMapExample extends StatefulWidget {
    int? id1;

  GoogleMapExample({Key? key,this.id1}) : super(key: key);
  @override
  State<GoogleMapExample> createState() => _GoogleMapExampleState();
}

class _GoogleMapExampleState extends State<GoogleMapExample> {
bool  isLoading = true;
int? id=0;
    WeatherModal? weathermodal;
  List<Location>? placemarks;
GoogleMapController? _controller;

  getaddress()async{

    List<Location> locations = await locationFromAddress (weathermodal?.data?[id!].name ?? "");
    Location location = locations.first;
    setState(() {
      latitude = location.latitude;
      longitude = location.longitude;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather();
    setState(() {
      id = widget.id1;
    });
        }
Set<Marker> _createMarker() {
  return {
    Marker(
        markerId: const MarkerId("marker_1"),
        position:LatLng(latitude!,longitude!),
        infoWindow: const InfoWindow(title: 'Marker 1'),
        rotation: 0),
  };
}
void _onMapCreated(GoogleMapController controller) {
  setState(() {
    _controller= controller;
    Marker(
        markerId: const MarkerId("marker_1"),
        position: LatLng(latitude!,longitude!),
        infoWindow: const InfoWindow(title: 'Marker 1'),
        rotation: 0);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
        automaticallyImplyLeading: true,
      ),
      body:isLoading?Container():
      Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              // onScaleStart: (details) {
              //   _previousZoom = _getCurrentZoom();
              // },
              // onScaleUpdate: (details) {
              //   final double zoom = _previousZoom / details.scale;
              //   _controller?.animateCamera(CameraUpdate.zoomTo(zoom));
              // },
              child: GoogleMap(
                // minMaxZoomPreference:
                // MinMaxZoomPreference(0, 5),
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                scrollGesturesEnabled: true,

                mapType: MapType.normal,
                initialCameraPosition:CameraPosition(
                    target:LatLng(latitude!,longitude!),
                  zoom: 3
                ),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                markers: _createMarker(),
              ),
            ),
          ),
          weathermodal?.data?.length == 1 ?Container(): Container(
              width:MediaQuery.of(context).size.width,
              height:8.h,
              color:Colors.white,
              // color: Colors.black.withOpacity(0.7),
              // color: Colors.black.withOpacity(0.7),
              child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:weathermodal?.data?.length ,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        id =index;
                      });
                      weather();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        margin: EdgeInsets.only(left: 3.w,top:3.w,bottom: 3.w),
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),

                            border:Border.all( width:2,
                                color:(id == index) ?Colors.blue: Colors.black)),
                        // ),


                        child:Text(weathermodal?.data?[index].name ?? "",
                          style: TextStyle(
                              color:(id== index)?Colors.blueAccent: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins"
                          ),)
                    ),
                  );
                },
              )
          ),
        ],
      ),

    );
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
          getaddress();
          _createMarker();


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
      buildErrorDialog(context, 'Error', "Internate Required");
    }
  });
}
}


