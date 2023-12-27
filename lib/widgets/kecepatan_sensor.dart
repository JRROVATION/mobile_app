import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/data_latest.dart';

class KecepatanSensor extends StatelessWidget {
  const KecepatanSensor({
    required this.apiData,
    Key? key,
  }) : super(key: key);
  
  final LatestData apiData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height: 87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: GestureDetector(
        onTap: () {
          // Add logic or navigation as needed
        },
        child: Stack(
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
                            '${apiData.kecepatan.toStringAsFixed(2)}', // Display relevant data from LatestData
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
