import 'package:connectivity_plus/connectivity_plus.dart';
import "package:flutter/material.dart";

Future<void> checkInternetConnectivity() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  switch (connectivityResult) {
    case ConnectivityResult.mobile:
      break;
    default:
  }
  if (ConnectivityResult.values.contains(ConnectivityResult.mobile)) {
    // I am connected to a mobile network.
    debugPrint('Connected to mobile data');
  } else if (ConnectivityResult.values.contains(ConnectivityResult.wifi)) {
    // I am connected to a wifi network.
    debugPrint('Connected to Wi-Fi');
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    // I am connected to a ethernet network.
    debugPrint('Connected to ethernet');
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    // I am connected to a bluetooth network.
    debugPrint('Connected to bluetooth');
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a network which is not mobile, wifi or ethernet.
    debugPrint('Connected to other');
  } else if (connectivityResult == ConnectivityResult.none) {
    // I am not connected to any network.
    debugPrint('No internet connection');
  } else {
    debugPrint("no connection found");
  }
}
