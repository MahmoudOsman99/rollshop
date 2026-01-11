// check if the app is in debug mode print the send value to the console
import 'package:flutter/foundation.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  if (kDebugMode) {
    inDebugMode = true;
  }
  return inDebugMode;
}

void printServiceDebug(String message) {
  if (isInDebugMode) {
    // ignore: avoid_print
    print(message);
  }
}
