import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/widgets/keadaan_emosi.dart';
import 'package:mobile_app/widgets/kantuk_notf.dart';
import 'package:mobile_app/widgets/kecepatan_sensor.dart';
import 'package:mobile_app/widgets/maps.dart';
import 'package:mobile_app/widgets/kecepatan_notf.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.isServerConnected,
  });

  final bool isServerConnected;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final date =
        DateFormat("EEEE, d MMMM yyyy", "id_ID").format(DateTime.now());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 47 / 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !widget.isServerConnected
                  ? const Text("Connecting to server...")
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Pagi',
                      style: GoogleFonts.poppins(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              MapsLocation(),
              const SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KeadaanEmosi(),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KantukNotf(),
                        const SizedBox(height: 7),
                        // DurasiNotf(),
                        // const SizedBox(height: 7),
                        KecepatanNotf(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              KecepatanSensor(),
              const SizedBox(height: 17),
              // const RincianSensor(),
              // const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
