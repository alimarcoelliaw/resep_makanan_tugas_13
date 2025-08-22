import 'package:flutter/material.dart';
import 'package:resep_makanan/loginscreen.dart';
import 'package:resep_makanan/main_screen.dart';
import 'package:resep_makanan/screens/add_recipe.dart';
import 'package:resep_makanan/screens/edit_recipe.dart';
// import 'package:resep_makanan/screens/recipe_detail.dart';
import 'package:resep_makanan/screens/recipe_list.dart';
import 'package:resep_makanan/screens/recipt_detail.dart';
import 'package:resep_makanan/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Makanan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Day16SplashScreen.id,
      routes: {
        Day16SplashScreen.id: (context) => const Day16SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        MainScreen.id: (context) => const MainScreen(),
        RecipeListScreen.id: (context) => const RecipeListScreen(),
        AddRecipeScreen.id: (context) => const AddRecipeScreen(),
        EditRecipeScreen.id: (context) => const EditRecipeScreen(),
        RecipeDetailScreen.id: (context) => const RecipeDetailScreen(),
      },
    );
  }
}
