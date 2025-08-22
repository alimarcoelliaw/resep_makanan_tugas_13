import 'package:flutter/material.dart';
import 'package:resep_makanan/extension/navigation.dart';
import 'package:resep_makanan/loginscreen.dart';
import 'package:resep_makanan/preference/shared_preference.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("simpan yuk")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 60, 82, 207),
              border: Border.all(color: Colors.red, width: 10),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Image.asset(
                "assets/images/masakyuk.png", // ganti dengan path gambar kamu
                fit: BoxFit.contain,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              PreferenceHandler.removeLogin();
              context.pushReplacementNamed(LoginScreen.id);
            },
            child: const Text("Keluar"),
          ),
        ],
      ),
    );
  }
}
