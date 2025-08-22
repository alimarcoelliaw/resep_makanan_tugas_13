import 'package:path/path.dart';
import 'package:resep_makanan/model/recipe.dart';
import 'package:resep_makanan/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> databaseHelper() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'recipes.db'),
      onCreate: (db, version) async {
        // Buat tabel users
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, email TEXT, password TEXT, name TEXT)',
        );

        // Buat tabel recipes
        await db.execute('''
          CREATE TABLE recipes(
            id INTEGER PRIMARY KEY,
            title TEXT,
            ingredients TEXT,
            steps TEXT,
            category TEXT,
            cooking_time INTEGER,
            difficulty TEXT,
            user_id INTEGER,
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
      version: 2, // Tingkatkan versi database
    );
  }

  // Method untuk user (sudah ada)
  static Future<void> registerUser(User user) async {
    final db = await databaseHelper();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<User?> loginUser(String email, String password) async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    }
    return null;
  }

  static Future<List<User>> getAllUsers() async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query('users');
    return results.map((e) => User.fromMap(e)).toList();
  }

  // Method untuk resep (baru)
  static Future<int> addRecipe(Recipe recipe) async {
    final db = await databaseHelper();
    return await db.insert('recipes', recipe.toMap());
  }

  static Future<List<Recipe>> getRecipesByUserId(int userId) async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query(
      'recipes',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'title ASC',
    );
    return results.map((e) => Recipe.fromMap(e)).toList();
  }

  static Future<Recipe?> getRecipeById(int id) async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return Recipe.fromMap(results.first);
    }
    return null;
  }

  static Future<int> updateRecipe(Recipe recipe) async {
    final db = await databaseHelper();
    return await db.update(
      'recipes',
      recipe.toMap(),
      where: 'id = ?',
      whereArgs: [recipe.id],
    );
  }

  static Future<int> deleteRecipe(int id) async {
    final db = await databaseHelper();
    return await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
  }
}
