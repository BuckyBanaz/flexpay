// card_customization_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CardCustomizationController extends GetxController {
  // selected style index
  RxInt selectedStyle = 0.obs;

  // initialize with a valid default color index for each style
  late RxList<int> selectedColorForStyle;

  // styles (same as before)
  final List<Map<String, dynamic>> styles = [
    {
      "title": "Premium • Space Grey",
      "subtitle": "Made from plastic with a striking shimmer effect, our beautiful Premium card feels as good as it looks",
      "colors": [
        [Color(0xFF6B7280), Color(0xFF6B7280)],
        [Color(0xFFFDA4AF), Color(0xFFFCA5A5)],
        [Color(0xFF9B7BFF), Color(0xFF7C3AED)],
      ],
      "locked": false,
    },
    {
      "title": "Metal • Premium Black",
      "subtitle": "Luxurious metal card with premium finish and exclusive benefits",
      "colors": [
        [Color(0xFF0F172A), Color(0xFF1F2937)],
        [Color(0xFF4B5563), Color(0xFF6B7280)],
        [Color(0xFFB5883E), Color(0xFFD4973A)],
      ],
      "locked": true,
    }
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize selectedColorForStyle with 0 for each style (or pick any default)
    selectedColorForStyle = RxList<int>.from(List<int>.filled(styles.length, 0));
  }

  void selectStyle(int i) {
    if (styles[i]["locked"] == true) return;
    selectedStyle.value = i;
    // ensure there's a valid color index
    if (selectedColorForStyle[i] < 0 || selectedColorForStyle[i] >= (styles[i]['colors'] as List).length) {
      selectedColorForStyle[i] = 0;
    }
  }

  void selectColor(int styleIndex, int colorIndex) {
    if (styles[styleIndex]["locked"] == true) return;
    selectedColorForStyle[styleIndex] = colorIndex;
    update();
    // no need to call update() because RxList will notify listeners
  }

  void getCard() {
    final style = styles[selectedStyle.value];
    final colorIdx = selectedColorForStyle[selectedStyle.value];
    Get.snackbar("Get Card", "Style: ${style['title']} - Color #$colorIdx",
        snackPosition: SnackPosition.BOTTOM);
  }
}

