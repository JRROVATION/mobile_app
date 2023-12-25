import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KecepatanSensor extends StatefulWidget {
  const KecepatanSensor({super.key});
  @override
  State<KecepatanSensor> createState() {
    return _KecepatanSensorState();
  }
}

class _KecepatanSensorState extends State<KecepatanSensor> {
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
      // color: const Color.fromRGBO(232, 232, 232, 1),
      width: 362,
      height: 87,
      // alignment: Alignment.center,
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
                  padding: const EdgeInsets.only(left:15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom:30.0),
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
                            '60.3',
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 15.0, 20.0),
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
