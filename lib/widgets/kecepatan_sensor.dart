import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class KecepatanSensor extends StatefulWidget {
  const KecepatanSensor({Key? key}) : super(key: key);

  @override
  State<KecepatanSensor> createState() {
    return _KecepatanSensorState();
  }
}

class _KecepatanSensorState extends State<KecepatanSensor> {
  String kecepatanValue = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://iwms.site:9898/api'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final double kecepatan = data['message']['kecepatan'];
        setState(() {
          kecepatanValue = kecepatan.toStringAsFixed(1); // Menampilkan satu angka desimal
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _openLiveMapOverlay() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (ctx) {
        return const Column(
          children: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height: 87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: IconButton(
        onPressed: _openLiveMapOverlay,
        icon: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          'Kecepatan',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            kecepatanValue,
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 0.0, 15.0, 20.0),
                            child: Text(
                              'km/j',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
