import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/sensor.dart';

class MapsLocation extends StatefulWidget {
  MapsLocation({
    super.key,
    required this.sensorData,
    required this.locationUpdatedNotif,
  });

  SensorData sensorData;
  ValueNotifier locationUpdatedNotif;

  @override
  State<StatefulWidget> createState() {
    return _MapsLocationState();
  }
}

class _MapsLocationState extends State<MapsLocation> {
  late MapController controller;
  GeoPoint markerPos = GeoPoint(latitude: -7.0, longitude: 110.0);

  @override
  void initState() {
    super.initState();
    initMap();
  }

  @override
  void dispose() {
    super.dispose();
    widget.locationUpdatedNotif.removeListener(updateLocation);
  }

  void initMap() async {
    controller = MapController(
      // initMapWithUserPosition: const UserTrackingOption(enableTracking: false),
      initPosition: markerPos,
    );

    controller.listenerMapSingleTapping.addListener(() {
      if (controller.listenerMapSingleTapping.value != null) {
        // double latitude =
        //     controller.listenerMapSingleTapping.value!.latitude.toDouble();
        // print(latitude);
      }
    });

    widget.locationUpdatedNotif.addListener(updateLocation);
  }

  void updateLocation() async {
    if (mounted) {
      final new_location = GeoPoint(
        latitude: widget.sensorData.location.latitude,
        longitude: widget.sensorData.location.longitude,
      );
      await controller.goToLocation(new_location);
      await controller.removeMarker(markerPos);
      await controller.addMarker(new_location,
          markerIcon: MarkerIcon(
            icon: Icon(
              Icons.car_crash,
              color: Colors.amber.shade900,
            ),
          ));

      markerPos = new_location;
      print("SAFJASFJLAKSFJPKASJFLKLASJKFASFK:LASA : $markerPos");
    }
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
        onMapIsReady: (p0) async {
          await controller.addMarker(markerPos,
              markerIcon: MarkerIcon(
                icon: Icon(
                  Icons.car_crash,
                  color: Colors.amber.shade900,
                ),
              ));
        },
        osmOption: OSMOption(
          zoomOption: ZoomOption(
            initZoom: 14,
            maxZoomLevel: 19,
            minZoomLevel: 2,
            stepZoom: 1.0,
          ),
          markerOption: MarkerOption(
            defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
