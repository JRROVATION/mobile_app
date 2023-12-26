import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';

class BluetoothPairing extends StatefulWidget {
  const BluetoothPairing({Key? key}) : super(key: key);

  @override
  _BluetoothPairingState createState() => _BluetoothPairingState();
}

class _BluetoothPairingState extends State<BluetoothPairing> {
  bool isBluetoothOn =
      false; // State untuk mengetahui apakah Bluetooth aktif atau tidak
  bool isPairing = false; // State untuk mengetahui apakah sedang proses pairing
  bool isPaired =
      false; // State untuk mengetahui apakah proses pairing sudah selesai

  void toggleBluetooth() {
    setState(() {
      isBluetoothOn = !isBluetoothOn;
      if (isBluetoothOn) {
        isPairing = true;
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isPairing = false;
            isPaired = true; // Setelah proses pairing selesai
          });
          if (isPaired) {
            Future.delayed(const Duration(seconds: 1), () {
              // Navigasi ke MainScreen setelah proses pairing selesai
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bluetooth Pair",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    toggleBluetooth();
                  },
                  child: Image.asset(
                    isBluetoothOn
                        ? 'assets/images/bluetooth_pressed.png'
                        : 'assets/images/bluetooth_button.png',
                    height: 257,
                    width: 257,
                  ),
                ),
                if (isPairing)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Pairing...',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                if (!isPairing && isPaired)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Paired',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              },
              child: Text(
                'Skip >>>',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
