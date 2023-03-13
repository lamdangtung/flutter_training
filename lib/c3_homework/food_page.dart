import 'package:flutter/material.dart';
import 'package:flutter_training/c3_homework/big_food_card.dart';
import 'package:flutter_training/c3_homework/food_card.dart';
import 'package:flutter_training/c3_homework/food_entity.dart';
import 'package:flutter_training/c3_homework/load_status.dart';
import 'package:flutter_training/utils/app_theme.dart';
import 'package:flutter_training/utils/constant.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});
  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late AppTheme theme;
  var foods = Data.foods.sublist(0, 10);
  var loadStatus = LoadStatus.initial;
  late final ScrollController scrollController;
  final _scrollThreshold = 200.0;
  bool isLoadMoreRunning = false;
  int currentSize = 10;
  @override
  void initState() {
    super.initState();
    theme = LightTheme();
    setState(() {
      loadStatus = LoadStatus.loading;
    });
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() {
        loadStatus = LoadStatus.loaded;
      });
    });
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  Future<void> scrollListener() async {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !isLoadMoreRunning) {
      setState(() {
        isLoadMoreRunning = true;
      });
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        setState(() {
          int currentSize = foods.length;

          foods = Data.foods.sublist(
              0,
              (currentSize + 10) < Data.foods.length - 1
                  ? (currentSize + 10)
                  : Data.foods.length - 1);
          isLoadMoreRunning = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    print(isLoadMoreRunning);
    final size = MediaQuery.of(context).size;
    if (loadStatus == LoadStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () {
            setState(() {
              loadStatus = LoadStatus.loading;
              foods = [];
            });
            return Future.delayed(const Duration(seconds: 2))
                .then((value) => setState(() {
                      loadStatus = LoadStatus.loaded;
                      foods = List.from(Data.foods.sublist(0, 10));
                    }));
          },
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
                SizedBox(
                  height: 160,
                  child: PageView.builder(
                      itemCount: Data.foods.length,
                      itemBuilder: (context, index) => const BigFoodCard()),
                ),
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
                    Text(
                      "Most Popular",
                      style: TextStyle(
                          color: theme.accentIconColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Icon(
                      Icons.sort,
                      size: 28,
                      color: theme.accentIconColor,
                    )
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    child: GridView.builder(
                      controller: scrollController,
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      itemCount: foods.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: kSmallPadding,
                              crossAxisSpacing: kSmallPadding,
                              mainAxisExtent: 260,
                              crossAxisCount: 2),
                      itemBuilder: (_, index) => FoodCard(
                        onBookMarkChanged: () {
                          foods[index].isMarked = !foods[index].isMarked;
                        },
                        food: foods[index],
                        width:
                            (size.width - 2 * kDefaultPadding - kSmallPadding) /
                                2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoadMoreRunning
            ? const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: SizedBox(
                    height: 48,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
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

class Data {
  static final foods = [
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Vegetable and Fruit Green Salad"),
    FoodEntity(
        author: "Phyllis Godley", title: "Fresh Seasoned Vegetable Salad"),
    FoodEntity(
        author: "Willard Purnell", title: "Vegetable and Fruit Green Salad"),
  ];
}
