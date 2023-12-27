import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class KeadaanEmosi extends StatefulWidget {
  const KeadaanEmosi({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _KeadaanEmosiState();
  }
}

class _KeadaanEmosiState extends State<KeadaanEmosi> {
  String ekspresiVal = "";

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
        final String emosi = data['message']['emosi'];
        setState(() {
          ekspresiVal = emosi;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _openMonitorGraphOverlay() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (ctx) {
        return Column(
          children: [
            Text(
              'Keadaan Emosi',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromRGBO(232, 232, 232, 1),
      width: 172,
      height: 173,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: IconButton(
        onPressed: _openMonitorGraphOverlay,
        icon: Stack(
          children: [
            // Column(
            //   children: [
            //     const SizedBox(
            //       height: 50,
            //     ),
            //     Image.asset('assets/images/line_chart.png'),
            //   ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                  width: 135,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Text(
                    'Keadaan Emosi',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        ekspresiVal,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
