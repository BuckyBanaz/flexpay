import 'package:flex/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../modules/swap/swap_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AmountCardType { send, get }

class AmountCard extends StatelessWidget {
  final SwapController controller;
  final AmountCardType which;
  final String label;
  final BorderRadius radius;

  // key used to get position of the currency pill
  final GlobalKey _currencyKey = GlobalKey();

  AmountCard({
    super.key,
    required this.controller,
    required this.which,
    required this.label,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController =
    which == AmountCardType.send ? controller.youSendCtrl : controller.youGetCtrl;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: radius,
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: TextField(
              controller: textController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
              decoration: const InputDecoration(isDense: true, border: InputBorder.none, contentPadding: EdgeInsets.zero),
              onChanged: (v) {
                if (which == AmountCardType.send) controller.setYouSend(v);
                else controller.setYouGet(v);
              },
            ),
          ),
          const SizedBox(width: 12),
          // currency pill with key
          GestureDetector(
            onTap: () => _showCurrencyPopup(context),
            child: Obx(() {
              final String cur = which == AmountCardType.send ? controller.from : controller.to;
              return Container(
                key: _currencyKey,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                ),
                child: Row(children: [
                  CircleAvatar(radius: 10, backgroundColor: Colors.transparent, child: Text(controller.emojiFor(cur), style: const TextStyle(fontSize: 14))),
                  const SizedBox(width: 8),
                  Text(cur, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 6),
                  const Icon(Icons.keyboard_arrow_down, size: 18),
                ]),
              );
            }),
          )
        ])
      ]),
    );
  }

  Future<void> _showCurrencyPopup(BuildContext context) async {
    // get position & size of the currency pill
    final RenderBox box = _currencyKey.currentContext!.findRenderObject() as RenderBox;
    final Offset topLeft = box.localToGlobal(Offset.zero);
    final Size size = box.size;

    // construct a RelativeRect so the menu appears below the pill
    final RelativeRect position = RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy + size.height,
      topLeft.dx + size.width,
      topLeft.dy,
    );

    // show menu
    final String? picked = await showMenu<String>(
      context: context,
      position: position,
      items: controller.currencies.map((c) {
        final bool isSelected = (which == AmountCardType.send ? controller.from : controller.to) == c;
        return PopupMenuItem<String>(
          value: c,
          // custom child to match screenshot style
          child: Row(
            children: [
              if (isSelected)
                const Icon(Icons.check, size: 18, color: Colors.teal)
              else
                const SizedBox(width: 18),
              const SizedBox(width: 8),
              Text(controller.emojiFor(c), style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 12),
              Text(c, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        );
      }).toList(),
      elevation: 8,

      // popup background color + shape (dark rounded box)
      color: AppColors.scaffold,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    if (picked != null) {
      if (which == AmountCardType.send) {
        controller.setFrom(picked);
      } else {
        controller.setTo(picked);
      }
      // update rate (controller handles mock rate update)
      controller.updateMockRate();
    }
  }
}
