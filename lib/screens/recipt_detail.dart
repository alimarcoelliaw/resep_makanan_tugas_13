import 'package:flutter/material.dart';
import 'package:resep_makanan/model/recipe.dart';
// import 'package:resep_makanan/models/recipe.dart';
import 'package:resep_makanan/sqflite/db_helper.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});
  static const id = "/recipe_detail";

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Recipe _recipe;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadRecipe();
    }
  }

  Future<void> _loadRecipe() async {
    final recipeId = ModalRoute.of(context)!.settings.arguments as int;
    final recipe = await DbHelper.getRecipeById(recipeId);

    if (recipe != null) {
      setState(() {
        _recipe = recipe;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(_recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _recipe.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Chip(label: Text(_recipe.category)),
                        const SizedBox(width: 8),
                        Chip(label: Text(_recipe.difficulty)),
                        const SizedBox(width: 8),
                        Chip(label: Text('${_recipe.cookingTime} menit')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bahan-bahan:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_recipe.ingredients),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Langkah-langkah:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_recipe.steps),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
