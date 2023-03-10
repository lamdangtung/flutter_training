class FoodEntity {
  final String author;
  final String title;
  bool isMarked;
  FoodEntity({
    required this.author,
    required this.title,
    this.isMarked = false,
  });
}
