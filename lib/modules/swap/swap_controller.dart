import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwapController extends GetxController {
  // text controllers
  final TextEditingController youSendCtrl = TextEditingController(text: '1000');
  final TextEditingController youGetCtrl = TextEditingController(text: '920');

  // reactive primitives
  final RxString youSendText = '1000'.obs;
  final RxString youGetText = '920'.obs;

  final RxString _from = 'USD'.obs;
  final RxString _to = 'EUR'.obs;

  final RxDouble _exchangeRate = 0.92.obs;
  final double networkFee = 5.00;

  // currency list (could be fetched)
  final List<String> currencies = ['USD', 'EUR', 'BTC', 'ETH'];

  // convenience: map code -> translation key
  String currencyKey(String code) => 'currency_$code';

  // getters for convenience
  String get from => _from.value;
  String get to => _to.value;
  double get exchangeRate => _exchangeRate.value;
  String get exchangeRateString => _exchangeRate.value.toStringAsFixed(2);
  double get networkFeeValue => networkFee;

  @override
  void onInit() {
    super.onInit();
    // keep RxStrings in sync with controllers (so UI button updates as you type)
    youSendCtrl.addListener(() => youSendText.value = youSendCtrl.text);
    youGetCtrl.addListener(() => youGetText.value = youGetCtrl.text);
  }

  void setYouSend(String val) => youSendText.value = val;
  void setYouGet(String val) => youGetText.value = val;

  // ---------- Public helpers added for AmountCard usage ----------
  /// Set the "from" currency (used by AmountCard popup)
  void setFrom(String c) {
    _from.value = c;
    _updateMockRate();
  }

  /// Set the "to" currency (used by AmountCard popup)
  void setTo(String c) {
    _to.value = c;
    _updateMockRate();
  }

  /// Public wrapper so UI can call to refresh mocked rates
  void updateMockRate() => _updateMockRate();

  /// Emoji helper (already present) - used by widgets to show flags/icons
  String emojiFor(String currency) {
    switch (currency) {
      case 'USD':
        return '🇺🇸';
      case 'EUR':
        return '🇪🇺';
      case 'BTC':
        return '₿';
      case 'ETH':
        return 'Ξ';
      default:
        return '🏳️';
    }
  }
  // ---------------------------------------------------------------

  // show currency picker - using Get.bottomSheet for modular approach
  void showCurrencyPicker({required bool isFrom}) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: currencies.map((c) {
            final selected = (isFrom ? from : to) == c;
            return ListTile(
              leading: Text(emojiFor(c), style: const TextStyle(fontSize: 22)),
              // use localized currency name:
              title: Text(currencyKey(c).tr, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: selected ? const Icon(Icons.check, color: Colors.teal) : null,
              onTap: () {
                if (isFrom) setFrom(c);
                else setTo(c);
                Get.back();
              },
            );
          }).toList(),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  // simple swap logic
  void swapCurrencies() {
    final tmp = _from.value;
    _from.value = _to.value;
    _to.value = tmp;

    // swap text values
    final tmpAmt = youSendCtrl.text;
    youSendCtrl.text = youGetCtrl.text;
    youGetCtrl.text = tmpAmt;

    // update rate (mock)
    _updateMockRate();
  }

  void _updateMockRate() {
    // very simple mocked mapping for demo
    if (_from.value == 'USD' && _to.value == 'EUR') _exchangeRate.value = 0.92;
    else if (_from.value == 'EUR' && _to.value == 'USD') _exchangeRate.value = 1.09;
    else if (_from.value == 'BTC' || _to.value == 'BTC') _exchangeRate.value = 0.000021;
    else _exchangeRate.value = 0.01;
  }

  void onSwapPressed() {
    final fromAmt = youSendCtrl.text;
    // use trArgs to pass amount, from and to (localized currency names)
    final fromName = currencyKey(_from.value).tr;
    final toName = currencyKey(_to.value).tr;

    Get.snackbar(
      'swap'.tr,
      'swapping'.trArgs([fromAmt, fromName, toName]),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // dispose controllers
  @override
  void onClose() {
    youSendCtrl.dispose();
    youGetCtrl.dispose();
    super.onClose();
  }
}
