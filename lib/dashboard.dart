import 'package:flutter/material.dart';
// import 'package:resep_makanan/main.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});
  static const id = "/DashboardScreen";

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            'Selamat datang di Dashboard aplikasi kami.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Back'),
          // ),
        ],
      ),
    );
  }
}
