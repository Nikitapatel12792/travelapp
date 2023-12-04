
import 'dart:async';
import 'dart:convert';


import 'package:escapingplan/Modal/detailmodel.dart';
import 'package:escapingplan/Provider/travelprovider.dart';
import 'package:escapingplan/widget/buildErrorDialog.dart';
import 'package:escapingplan/widget/const.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
class GoogleMapExample1 extends StatefulWidget {
  String? loc;
  GoogleMapExample1({Key? key,this.loc}) : super(key: key);

  @override
  State<GoogleMapExample1> createState() => _GoogleMapExample1State();
}
double? latitude = 0.0;
double? longitude = 0.0;
class _GoogleMapExample1State extends State<GoogleMapExample1> {
  final Set<Marker> _markers = {};
  // String address = "Surat,Gujarat";
  // var currentLocation = LocationData;
  List<Location>? placemarks;
  bool isLoading = true;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  getaddress()async{
    String? positionString = detailmodal?.latlong;
    print(positionString);

    List<String>? parts = positionString!.split(",");
    setState(() {
      latitude = double.parse(parts[0]);
      longitude = double.parse(parts[1]);
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // isLoading=true;
    detailap();
    getaddress();
    print(widget.loc);
    // _timer = Timer.periodic(Duration(seconds: 10), (Timer t) => getLocation());
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
    _controller.complete(controller);
    setState(() {
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
        body: SizedBox(
          height: 40.h,
          width: 90.w,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition:CameraPosition(
                target:LatLng(latitude!,longitude!),
                zoom: 3.0
            ),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            markers: _createMarker(),
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: const Text('To the lake!'),
        //   icon: const Icon(Icons.directions_boat),
        // ),
    );

  }
  detailap() {

    final Map<String, String> data = {};
    data['itinerary_id'] = widget.loc.toString();
    data['action'] = 'detail_page';
    checkInternet().then((internet) async {
      if (internet) {
        travelprovider().detailapi(data).then((Response response) async {
          detailmodal = DetailModel.fromJson(json.decode(response.body));
          if (response.statusCode == 200 && detailmodal?.status == 1) {
            setState(() {
              // isLoading = false;
            });
            if (kDebugMode) {}
          } else {
            setState(() {
              // isLoading = false;
            });
            // buildErrorDialog(context, "", "Invalid login");
          }
        });
      } else {
        setState(() {
          // isLoading = false;
        });
        buildErrorDialog(context, 'Error', "Internate Required");
      }
    });
  }
}

