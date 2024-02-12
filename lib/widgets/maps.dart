import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/sensor.dart';

class MapsLocation extends StatefulWidget {
  MapsLocation({
    super.key,
    required this.sensorData,
  });

  SensorData sensorData;

  @override
  State<StatefulWidget> createState() {
    return _MapsLocationState();
  }
}

class _MapsLocationState extends State<MapsLocation> {
  late MapController controller;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        // _loadData();
      }
    });
    controller = MapController(
      initMapWithUserPosition: const UserTrackingOption(enableTracking: true),
    );

    controller.listenerMapSingleTapping.addListener(() {
      if (controller.listenerMapSingleTapping.value != null) {
        double latitude =
            controller.listenerMapSingleTapping.value!.latitude.toDouble();
        print(latitude);
      }
    });
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return Container(
      height: 362,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: OSMFlutter(
        controller: controller,
        osmOption: const OSMOption(
          zoomOption: ZoomOption(
            initZoom: 17,
            maxZoomLevel: 19,
            minZoomLevel: 2,
            stepZoom: 1.0,
          ),
        ),
      ),
    );
  }
}
