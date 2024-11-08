import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/sensor.dart';

class KecepatanSensor extends StatefulWidget {
  KecepatanSensor({
    super.key,
    required this.sensorData,
  });

  SensorData sensorData;

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
        return Container(
          width: double.infinity,
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
        icon: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    Container(
                      // padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Kecepatan',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.sensorData.speed}',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
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
        ),
      ),
    );
  }
}
