class Recipe {
  final int? id;
  final String title;
  final String ingredients;
  final String steps;
  final String category;
  final int cookingTime;
  final String difficulty;
  final int userId;

  Recipe({
    this.id,
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.category,
    required this.cookingTime,
    required this.difficulty,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'steps': steps,
      'category': category,
      'cooking_time': cookingTime,
      'difficulty': difficulty,
      'user_id': userId,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      ingredients: map['ingredients'],
      steps: map['steps'],
      category: map['category'],
      cookingTime: map['cooking_time'],
      difficulty: map['difficulty'],
      userId: map['user_id'],
    );
  }
}
