import 'package:flutter/material.dart';
import 'package:resep_makanan/extension/navigation.dart';
import 'package:resep_makanan/screens/add_recipe.dart';
import 'package:resep_makanan/screens/recipe_list.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});
  static const id = "/DashboardScreen";

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant_menu, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Aplikasi Resep Makanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Temukan dan kelola resep masakan favorit Anda',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RecipeListScreen.id);
              },
              child: const Text('Lihat Daftar Resep'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                context.pushNamed(AddRecipeScreen.id);
              },
              child: const Text('Tambah Resep Baru'),
            ),
          ],
        ),
      ),
    );
  }
}
