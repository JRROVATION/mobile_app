import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class MapsLocation extends StatefulWidget with GetItStatefulWidgetMixin {
  MapsLocation({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _MapsLocationState();
  }
}

class _MapsLocationState extends State<MapsLocation> with GetItStateMixin {
  late MapController controller;
  GeoPoint markerPos = GeoPoint(latitude: -7.753068, longitude: 110.383636);

  final model = locator<AdviseViewModel>();

  @override
  void initState() {
    super.initState();
    initMap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initMap() async {
    controller = MapController(
      // initMapWithUserPosition: const UserTrackingOption(enableTracking: false),
      initPosition: markerPos,
    );

    // controller.listenerMapSingleTapping.addListener(() {
    //   if (controller.listenerMapSingleTapping.value != null) {
    //     // double latitude =
    //     //     controller.listenerMapSingleTapping.value!.latitude.toDouble();
    //     // print(latitude);
    //   }
    // });
  }

  void updateLocation(GeoPoint newLocation) async {
    if (mounted) {
      await Future.delayed(const Duration(milliseconds: 500));
      await controller.goToLocation(newLocation);
      await controller.removeMarker(markerPos);
      await controller.addMarker(newLocation,
          markerIcon: MarkerIcon(
            icon: Icon(
              Icons.car_crash,
              color: Colors.amber.shade900,
            ),
          ));

      controller.changeLocationMarker(
          oldLocation: markerPos, newLocation: newLocation);
      markerPos = newLocation;

      if (kDebugMode) {
        print("✅ Update lokasi: $markerPos");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GeoPoint? newLocation =
        watchOnly((AdviseViewModel only) => only.location);

    if (newLocation != null) {
      if (kDebugMode) {
        print(
            '⚠️ Akan memanggil updateLocation dengan lat=${newLocation.latitude}, lon=${newLocation.longitude}');
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateLocation(newLocation);
      });
    } else {
      print('lokasi null');
    }
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
        osmOption: const OSMOption(
          zoomOption: ZoomOption(
            initZoom: 14,
            maxZoomLevel: 19,
            minZoomLevel: 2,
            stepZoom: 1.0,
          ),
          // markerOption: MarkerOption(
          //   defaultMarker: const MarkerIcon(
          //     icon: Icon(
          //       Icons.person_pin_circle,
          //       color: Colors.blue,
          //       size: 56,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
