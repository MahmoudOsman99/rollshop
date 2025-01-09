// import 'package:connectivity_plus/connectivity_plus.dart';

// Future<void> checkInternetConnectivity() async {
//   var connectivityResult = await Connectivity().checkConnectivity();
//   switch (connectivityResult) {
//     case ConnectivityResult.mobile:
//       break;
//     default:
//   }
//   if (connectivityResult == ConnectivityResult.mobile) {
//     // I am connected to a mobile network.
//     print('Connected to mobile data');
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     // I am connected to a wifi network.
//     print('Connected to Wi-Fi');
//   } else if (connectivityResult == ConnectivityResult.ethernet) {
//     // I am connected to a ethernet network.
//     print('Connected to ethernet');
//   } else if (connectivityResult == ConnectivityResult.bluetooth) {
//     // I am connected to a bluetooth network.
//     print('Connected to bluetooth');
//   } else if (connectivityResult == ConnectivityResult.other) {
//     // I am connected to a network which is not mobile, wifi or ethernet.
//     print('Connected to other');
//   } else if (connectivityResult == ConnectivityResult.none) {
//     // I am not connected to any network.
//     print('No internet connection');
//   }
// }
