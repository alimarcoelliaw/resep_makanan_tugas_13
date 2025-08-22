import 'package:flutter/material.dart';
import 'package:resep_makanan/extension/navigation.dart';
import 'package:resep_makanan/model/recipe.dart';
import 'package:resep_makanan/screens/add_recipe.dart';
import 'package:resep_makanan/screens/edit_recipe.dart';
// import 'package:resep_makanan/screens/recipe_detail.dart';
import 'package:resep_makanan/screens/recipt_detail.dart';
import 'package:resep_makanan/sqflite/db_helper.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});
  static const id = "/recipe_list";

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> recipes = [];
  int? currentUserId;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    // Untuk demo, kita asumsikan user ID = 1
    // Dalam aplikasi nyata, Anda akan menyimpan dan mengambil ID user dari shared preferences
    final recipesList = await DbHelper.getRecipesByUserId(1);
    setState(() {
      recipes = recipesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Resep'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(AddRecipeScreen.id);
            },
          ),
        ],
      ),
      body: recipes.isEmpty
          ? const Center(child: Text('Belum ada resep. Tambah resep baru!'))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    title: Text(recipe.title),
                    subtitle: Text('Kategori: ${recipe.category}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            context.pushNamed(
                              EditRecipeScreen.id,
                              arguments: recipe.id,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteDialog(recipe);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      context.pushNamed(
                        RecipeDetailScreen.id,
                        arguments: recipe.id,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  void _showDeleteDialog(Recipe recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Resep'),
          content: Text('Yakin ingin menghapus ${recipe.title}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await DbHelper.deleteRecipe(recipe.id!);
                _loadRecipes(); // Refresh list
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${recipe.title} telah dihapus')),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
