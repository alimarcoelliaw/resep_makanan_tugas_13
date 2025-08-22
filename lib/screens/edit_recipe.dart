import 'package:flutter/material.dart';
import 'package:resep_makanan/model/recipe.dart';
// import 'package:resep_makanan/models/recipe.dart';
import 'package:resep_makanan/sqflite/db_helper.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({super.key});
  static const id = "/edit_recipe";

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late Recipe _recipe;
  bool _isLoading = true;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _cookingTimeController = TextEditingController();

  String _category = 'Main Course';
  String _difficulty = 'Mudah';

  final List<String> categories = [
    'Main Course',
    'Appetizer',
    'Dessert',
    'Snack',
    'Drink',
  ];

  final List<String> difficulties = ['Mudah', 'Sedang', 'Sulit'];

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
        _titleController.text = recipe.title;
        _ingredientsController.text = recipe.ingredients;
        _stepsController.text = recipe.steps;
        _cookingTimeController.text = recipe.cookingTime.toString();
        _category = recipe.category;
        _difficulty = recipe.difficulty;
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
      appBar: AppBar(title: const Text('Edit Resep')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Resep',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul resep tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(
                  labelText: 'Bahan-bahan (pisahkan dengan koma)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bahan-bahan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stepsController,
                decoration: const InputDecoration(
                  labelText: 'Langkah-langkah',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Langkah-langkah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cookingTimeController,
                decoration: const InputDecoration(
                  labelText: 'Waktu Memasak (menit)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Waktu memasak tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _difficulty,
                items: difficulties.map((String difficulty) {
                  return DropdownMenuItem<String>(
                    value: difficulty,
                    child: Text(difficulty),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _difficulty = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Tingkat Kesulitan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateRecipe,
                child: const Text('Perbarui Resep'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      final updatedRecipe = Recipe(
        id: _recipe.id,
        title: _titleController.text,
        ingredients: _ingredientsController.text,
        steps: _stepsController.text,
        category: _category,
        cookingTime: int.parse(_cookingTimeController.text),
        difficulty: _difficulty,
        userId: _recipe.userId,
      );

      await DbHelper.updateRecipe(updatedRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resep berhasil diperbarui')),
      );

      Navigator.pop(context);
    }
  }
}
