// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mobile_app/model/condition.dart';

class AdviseViewModel extends ChangeNotifier {
  final _url = Uri.https(
    'advise.zonainovasi.site',
    '/api',
  );

  GeoPoint? _location;
  GeoPoint? get location => _location;
  set location(GeoPoint? value) {
    _location = value;
    notifyListeners();
  }

  double? _speed;
  double? get speed => _speed;
  set speed(double? value) {
    _speed = value;
    notifyListeners();
  }

  Expression? _expression;
  Expression? get expression => _expression;
  set expression(Expression? value) {
    _expression = value;
    notifyListeners();
  }

  bool? _drowsiness;
  bool? get drowsiness => _drowsiness;
  set drowsiness(bool? value) {
    _drowsiness = value;
    notifyListeners();
  }

  String? _accessToken;
  String? get accessToken => _accessToken;
  set accessToken(String? value) {
    _accessToken = value;
    notifyListeners();
  }

  String? _deviceId;
  String? get deviceId => _deviceId;
  set deviceId(String? value) {
    _deviceId = value;
    notifyListeners();
  }

  Future<void> handleSignIn({
    required String username,
    required String password,
    Function? onSuccess,
    Function? onFailed,
  }) async {
    final completer = Completer();
    var response = await http.post(
      _url.replace(path: '/api/auth/sign-in'),
      body: convert.json.encode(
        {
          "username": username,
          "password": password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    if (kDebugMode) {
      print(response.statusCode);
      print(jsonResponse);
    }

    if (response.statusCode < 400) {
      deviceId = jsonResponse['user']['id'];
      accessToken = jsonResponse['access_token'];

      await eventSourceStream();

      if (onSuccess != null) onSuccess();
      completer.complete(true);
    } else {
      if (onFailed != null) onFailed();
      completer.complete(false);
    }
    return await completer.future;
  }

  Future<void> handleSignUp({
    required String username,
    required String password,
    required String email,
    required String name,
    required Function onSuccess,
    required Function onFailed,
  }) async {
    final completer = Completer();
    var response = await http.post(
      _url.replace(path: '/api/auth/sign-up'),
      body: convert.json.encode(
        {
          "username": username,
          "password": password,
          "email": email,
          "name": name,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    if (kDebugMode) {
      print(response.statusCode);
      print(jsonResponse);
    }

    if (response.statusCode < 400) {
      onSuccess;
      completer.complete(true);
    } else {
      onFailed;
      completer.complete(false);
    }
    return await completer.future;
  }

  Future<void> eventSourceStream() async {
    final client = http.Client();

    final req = http.Request(
      'GET',
      _url.replace(path: "/api/device/$deviceId/data/listen"),
    );

    req.headers.putIfAbsent("Authorization", () => "Bearer $accessToken");

    final http.StreamedResponse rstream = await client.send(req);

    rstream.stream.listen((onData) {
      try {
        final str = convert.utf8.decode(onData);
        final received = str.split('\n');
        final datastr = received.firstWhere((st) => st.contains('data'));

        final data = convert.json.decode(datastr.replaceFirst('data:', ''))
            as Map<String, dynamic>;

        // Mengakses elemen dari `data`
        final double _latitude = data["latitude"];
        final double _longitude = data["longitude"];
        final int _speed = data["speed"];
        final String _expression = data["expression"];
        final bool _drowsiness = data["drowsiness"];

        location = GeoPoint(latitude: _latitude, longitude: _longitude);
        speed = _speed.toDouble();
        expression = getExpressionFromString(_expression);
        drowsiness = _drowsiness;
      } catch (err) {
        if (kDebugMode) {
          print('error: $err');
        }
      }
    });
  }
}
