import 'package:flutter/material.dart';
import 'pairing_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    navigateToBPContent();
  }

  void navigateToBPContent() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BluetoothPairing()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGO',
              style: GoogleFonts.poppins(
                fontSize: 45,
                fontWeight: FontWeight.w500,
              ),
            ),
            // const SizedBox(height: 20),
            // const CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
