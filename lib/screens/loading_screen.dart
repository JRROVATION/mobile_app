import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/screens/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/screens/main_screen.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class LoadingScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with GetItStateMixin {
  final model = locator<AdviseViewModel>();
  @override
  void initState() {
    navigateToBPContent();
    super.initState();
  }

  void navigateToBPContent() async {
    Future.delayed(const Duration(seconds: 3), () async {
      final loggedIn = await model.handleRestrict();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loggedIn ? const MainScreen() : const Auth(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    watchOnly((AdviseViewModel only) => only.accessToken);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ADVISE',
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
