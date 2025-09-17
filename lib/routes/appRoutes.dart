import 'package:flex/screens/home/home_screen.dart';
import 'package:flex/screens/mainnav/mainnav_screen.dart';
import 'package:flex/screens/wallet/wallet_screen.dart';
import 'package:get/get.dart';

import '../screens/wallet/card_customization_screen.dart';
import '../screens/welcome/welcome_screen.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const main = '/main';
  static const home = '/home';
  static const wallet = '/wallet';
  static const customization = '/customization';

  static get routes => [
    // GetPage(name: splash, page: () =>  SplashScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen(),transition: Transition.rightToLeft),
    GetPage(name: main, page: () => MainNavScreen(),transition: Transition.rightToLeft),
    GetPage(name: home, page: () => HomeScreen(),transition: Transition.rightToLeft),
    GetPage(name: wallet, page: () => WalletScreen(),transition: Transition.rightToLeft),
    GetPage(name: customization, page: () => CardCustomizationScreen(),transition: Transition.rightToLeft),
  ];
}
