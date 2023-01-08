import 'package:flutter/material.dart';

extension ScaffoldMessengerStateUtils on ScaffoldMessengerState {
  void toast(String message) {
    showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }
}
