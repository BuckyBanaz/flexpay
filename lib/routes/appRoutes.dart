import 'package:flex/screens/home/home_screen.dart';
import 'package:flex/screens/mainnav/mainnav_screen.dart';
import 'package:flex/screens/wallet/wallet_screen.dart';
import 'package:get/get.dart';

import '../screens/pay/pay_screen.dart';
import '../screens/profile/settings/language_Screen.dart';
import '../screens/recevie/receive_screen.dart';
import '../screens/sendmoney/send_money_screen.dart';
import '../screens/swap/swap_screen.dart';
import '../screens/wallet/card_customization_screen.dart';
import '../screens/welcome/welcome_screen.dart';

class AppRoutes {
  static const welcome = '/welcome';
  static const main = '/main';
  static const home = '/home';
  static const wallet = '/wallet';
  static const customization = '/customization';
  static const sendMoney = '/sendMoney';
  static const swap = '/swap';
  static const pay = '/pay';
  static const receive = '/receive';
  static const language = '/language';

  static get routes => [
    // GetPage(name: splash, page: () =>  SplashScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen(),transition: Transition.rightToLeft),
    GetPage(name: main, page: () => MainNavScreen(),transition: Transition.rightToLeft),
    GetPage(name: home, page: () => HomeScreen(),transition: Transition.rightToLeft),
    GetPage(name: wallet, page: () => WalletScreen(),transition: Transition.rightToLeft),
    GetPage(name: customization, page: () => CardCustomizationScreen(),transition: Transition.rightToLeft),
    GetPage(name: sendMoney, page: () => SendMoneyScreen(),transition: Transition.rightToLeft),
    GetPage(name: swap, page: () => SwapScreen(),transition: Transition.rightToLeft),
    GetPage(name: pay, page: () => PayScreen(),transition: Transition.rightToLeft),
    GetPage(name: receive, page: () => ReceiveScreen(),transition: Transition.rightToLeft),
    GetPage(name: language, page: () => LanguageScreen(),transition: Transition.rightToLeft),
  ];
}
