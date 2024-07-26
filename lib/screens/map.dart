import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    required this.gotoHome,
    super.key,
  });
  final void Function() gotoHome;
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final List<GeoPoint> _latLonData = [
    GeoPoint(
      latitude: -7.7828,
      longitude: 110.3608,
    )
  ];

  late MapController controller;
  @override
  void initState() {
    super.initState();

    _loadData();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        _loadData();
      }
    });
    controller = MapController(
      initMapWithUserPosition: const UserTrackingOption(enableTracking: false),
    );
  }

  void _loadData() async {
    final url = Uri.http('iwms.site:9898', '/api', {
      'id': 'map',
      'type': 'get',
    });

    final response = await http.get(url);
    if (response.statusCode > 400) {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
    if (response.body == 'null') {
      return;
    }
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    // var counter = 0;

    _latLonData.clear();
    for (final item in jsonResponse['message']) {
      print('latitude: ${item['latitude']}');
      print('longitude: ${item['longitude']}');
      setState(() {
        _latLonData.add(GeoPoint(
          latitude: item['latitude'] + 0.0,
          longitude: item['longitude'] + 0.0,
        ));
      });
    }

    await controller.goToLocation(_latLonData.last);
    controller.clearAllRoads();
    String roadInformation = await controller.drawRoadManually(
      _latLonData,
      RoadOption(
        roadColor: Colors.red,
        roadWidth: 20,
      ),
    );

    // await controller.drawRoad(
    //   _latLonData.first,
    //   _latLonData.last,
    // );

    await controller.addMarker(_latLonData.last);
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      osmOption: const OSMOption(
        zoomOption: ZoomOption(
          initZoom: 17,
          maxZoomLevel: 19,
          minZoomLevel: 2,
          stepZoom: 1.0,
        ),
      ),
    );
  }
}
