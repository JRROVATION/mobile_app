import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/screens/loading_screen.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

// final theme = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.dark,
//     seedColor: const Color.fromARGB(255, 131, 57, 0),
//   ),
//   textTheme: GoogleFonts.poppinsTextTheme(),
// );

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  locator.allReady().then((_) async {
    if (kDebugMode) {
      print('Semua instance yang terdaftar: ${locator.toString()}');
    }
    await locator<AdviseViewModel>().loadAccessToken();
  });

  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    );
  }
}
