import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/c4_homework/c4_page.dart';
import 'package:flutter_training/c4_homework/widgets/title_item.dart';
import 'package:flutter_training/utils/app_images.dart';

class SVGListBuilder extends StatelessWidget {
  static const icons = [AppImages.icFaq, AppImages.icGroup, AppImages.icTerms];
  const SVGListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: icons
          .map(
            (e) => TitleItem(
              leading: SvgPicture.asset(
                e,
                height: 36,
                width: 36,
              ),
              trailing: Text(C4Page.titles[icons.indexOf(e)]),
            ),
          )
          .toList(),
    );
  }
}
