import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_images.dart';
import 'package:flutter_training/utils/constant.dart';

class BigFoodCard extends StatelessWidget {
  const BigFoodCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        color: Colors.pink,
      ),
      child: Stack(fit: StackFit.expand, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          child: Image.asset(
            AppImages.backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
            gradient: const LinearGradient(
                colors: [Colors.black12, Colors.black45],
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft),
          ),
        ),
        Positioned(
          bottom: kSmallPadding,
          left: kSmallPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Salad",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "16,278 recipes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ]),
    );
  }
}
