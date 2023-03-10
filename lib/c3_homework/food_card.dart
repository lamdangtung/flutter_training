import 'package:flutter/material.dart';
import 'package:flutter_training/c3_homework/food_entity.dart';
import 'package:flutter_training/utils/app_images.dart';
import 'package:flutter_training/utils/constant.dart';

class FoodCard extends StatefulWidget {
  const FoodCard(
      {super.key,
      required this.width,
      required this.food,
      required this.onBookMarkChanged});
  final double width;
  final FoodEntity food;
  final VoidCallback onBookMarkChanged;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: Container(
        color: Colors.blue,
        width: widget.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.backgroundImage2,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                  gradient: const LinearGradient(
                      colors: [Colors.black12, Colors.black45],
                      begin: Alignment.center,
                      end: Alignment.bottomLeft),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widget.width - 16,
                    child: Text(
                      widget.food.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.food.author,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                    widget.onBookMarkChanged.call();
                  },
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFe3242b),
                    ),
                    child: Icon(
                      widget.food.isMarked
                          ? Icons.bookmark_outline
                          : Icons.bookmark,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
