import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'core/app.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return FlexWallet();
      },
    ),
  );
}
