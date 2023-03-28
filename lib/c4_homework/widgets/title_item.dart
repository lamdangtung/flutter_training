import 'package:flutter/material.dart';
import 'package:flutter_training/utils/constant.dart';

class TitleItem extends StatelessWidget {
  final Widget leading;
  final Widget trailing;
  const TitleItem({super.key, required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: Colors.black12),
      margin: const EdgeInsets.all(kSmallPadding),
      padding: const EdgeInsets.all(kSmallPadding),
      child: Row(
        children: [
          leading,
          const SizedBox(
            width: kDefaultPadding,
          ),
          Expanded(child: trailing)
        ],
      ),
    );
  }
}
