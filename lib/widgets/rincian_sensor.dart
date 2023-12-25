import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RincianSensor extends StatefulWidget {
  const RincianSensor({super.key});
  @override
  State<StatefulWidget> createState() {
    return _RincianSensorState();
  }
}

class _RincianSensorState extends State<RincianSensor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 168,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      // child: IconButton(
      //   onPressed: _openLiveMapOverlay,
      //   icon: Stack(
      //     children: [
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Rincian',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 15),
                      child: Column(
                        children: [
                          Text(
                            'Durasi Perjalanan',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '00:10:59',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 15),
                      child: Column(
                        children: [
                          Text(
                            'Kcptn rata-rata',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '55',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'km/j',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 15),
                      child: Column(
                        children: [
                          Text(
                            'Durasi Total',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '02:10:59',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 15),
                      child: Column(
                        children: [
                          Text(
                            'Jarak',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '124',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'km',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      //     ],
      //   ),
      // ),
    );
  }
}
