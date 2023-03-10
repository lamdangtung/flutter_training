import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_training/c3_homework/big_food_card.dart';
import 'package:flutter_training/c3_homework/food_card.dart';
import 'package:flutter_training/c3_homework/food_entity.dart';
import 'package:flutter_training/utils/app_colors.dart';
import 'package:flutter_training/utils/app_images.dart';
import 'package:flutter_training/utils/app_theme.dart';
import 'package:flutter_training/utils/constant.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late AppTheme theme;
  final foods = [
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
  ];
  @override
  void initState() {
    super.initState();
    theme = LightTheme();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 36,
                    color: theme.iconColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Salad",
                    style: TextStyle(color: theme.textColor, fontSize: 32),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    _changeTheme.call();
                  },
                  child: Icon(
                    Icons.search,
                    size: 36,
                    color: theme.iconColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const BigFoodCard(),
            const SizedBox(
              height: kSmallPadding,
            ),
            Row(
              children: [
                Text(
                  "Sort by",
                  style: TextStyle(
                      color: theme.textColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Text(
                  "Most Popular",
                  style: TextStyle(
                      color: Color(0xFFe3242b),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(
                  Icons.sort,
                  size: 28,
                  color: Color(0xFFe3242b),
                )
              ],
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                itemCount: foods.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: kSmallPadding,
                    crossAxisSpacing: kSmallPadding,
                    mainAxisExtent: 260,
                    crossAxisCount: 2),
                itemBuilder: (_, index) => FoodCard(
                  onBookMarkChanged: () {
                    foods[index].isMarked = !foods[index].isMarked;
                  },
                  food: foods[index],
                  width: (size.width - 2 * kDefaultPadding - kSmallPadding) / 2,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _changeTheme() {
    if (theme is LightTheme) {
      theme = DarkTheme();
    } else {
      theme = LightTheme();
    }
    setState(() {});
  }
}
