import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/c4_homework/c4_page.dart';
import 'package:flutter_training/c4_homework/widgets/list_item.dart';
import 'package:flutter_training/utils/app_images.dart';

class PNGListBuilder extends StatelessWidget {
  static const images = [
    AppImages.imgFaq,
    AppImages.imgGroup,
    AppImages.imgTerms
  ];
  const PNGListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: images
          .map(
            (e) => ListItem(
              leading: Image.asset(
                e,
                height: 36,
                width: 36,
              ),
              trailing: Text(C4Page.titles[images.indexOf(e)]),
            ),
          )
          .toList(),
    );
  }
}
