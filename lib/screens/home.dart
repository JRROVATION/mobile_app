import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/widgets/keadaan_emosi.dart';
import 'package:mobile_app/widgets/berkendara_notf.dart';
import 'package:mobile_app/widgets/kantuk_notf.dart';
import 'package:mobile_app/widgets/kecepatan_sensor.dart';
import 'package:mobile_app/widgets/maps.dart';
import 'package:mobile_app/widgets/kecepatan_notf.dart';
import 'package:mobile_app/widgets/rincian_sensor.dart';

final formatter = DateFormat.yMMMMEEEEd();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final date = formatter.format(now);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 47 / 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15),
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
                        'Senin, 25 Desember 2023',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const MapsLocation(),
                const SizedBox(
                  height: 17,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KeadaanEmosi(),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        KantukNotf(),
                        SizedBox(
                          height: 7,
                        ),
                        DurasiNotf(),
                        SizedBox(
                          height: 7,
                        ),
                        KecepatanNotf(),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const KecepatanSensor(),
                const SizedBox(
                  height: 17,
                ),
                const RincianSensor(),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
