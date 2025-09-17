import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WalletController extends GetxController {
  var currentIndex = 0.obs;
  var cards = [
    {
      "number": "5000 0000 0000 0000",
      "name": "Sandy Chungus",
      "gradient": [Color(0xFF7F00FF), Color(0xFF00D4FF)],
    },
    {
      "number": "1234 5678 9876 5432",
      "name": "John Doe",
      "gradient": [Color(0xFFFF512F), Color(0xFFDD2476)],
    },
    {
      "number": "4321 8765 6789 1234",
      "name": "Alice Smith",
      "gradient": [Color(0xFF00c6ff), Color(0xFF0072ff)],
    }
  ];
}