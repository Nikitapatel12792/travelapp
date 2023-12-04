import 'package:connectivity/connectivity.dart';
import 'package:escapingplan/Modal/agentmodal.dart';
import 'package:escapingplan/Modal/detailmodel.dart';
import 'package:escapingplan/Modal/loginmodel.dart';
import 'package:escapingplan/Modal/partnersmodal.dart';
import 'package:geolocator/geolocator.dart';

import '../Modal/extramodal.dart';

Future<bool> checkInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

UserModal? userData;
Partnersmodal? partnerdata;
MyagentModal? agentdata;
ExtratravModal? extradata;
DetailModel? detailmodal;
const String baseUrl = 'http://portal.escapingplan.com/admin/api';

Future<bool> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    serviceEnabled = false;
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      serviceEnabled = false;
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    serviceEnabled = false;
    return false;
  }
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return serviceEnabled;
}
