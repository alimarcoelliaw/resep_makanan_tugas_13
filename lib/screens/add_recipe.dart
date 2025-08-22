import 'package:flutter/material.dart';
import 'package:resep_makanan/model/recipe.dart';
// import 'package:resep_makanan/models/recipe.dart';
import 'package:resep_makanan/sqflite/db_helper.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});
  static const id = "/add_recipe";

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Resep Baru')),
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
                onPressed: _saveRecipe,
                child: const Text('Simpan Resep'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        title: _titleController.text,
        ingredients: _ingredientsController.text,
        steps: _stepsController.text,
        category: _category,
        cookingTime: int.parse(_cookingTimeController.text),
        difficulty: _difficulty,
        userId: 1, // Untuk demo, gunakan user ID 1
      );

      await DbHelper.addRecipe(newRecipe);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Resep berhasil disimpan')));

      Navigator.pop(context);
    }
  }
}
