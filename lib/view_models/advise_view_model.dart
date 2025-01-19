import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mobile_app/model/condition.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:shared_preferences/shared_preferences.dart';

class AdviseViewModel extends ChangeNotifier {
  AdviseViewModel() {
    print('AdviseViewModel instance dibuat: $this');
  }
  final _url = Uri.https(
    'advise.zonainovasi.site',
    '/api',
  );

  String? _deviceId;
  String? get deviceId => _deviceId;
  set deviceId(String? value) {
    if (deviceId != value) {
      _deviceId = value;
      notifyListeners();
    }
  }

  String? _accessToken;
  String? get accessToken => _accessToken;
  set accessToken(String? value) {
    if (_accessToken != value) {
      _accessToken = value;
      _saveAccessToken(value);
      notifyListeners();
    }
  }

  Future<void> loadAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    notifyListeners();
  }

  Future<void> _saveAccessToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    if (token != null) {
      await prefs.setString('accessToken', token);
    } else {
      await prefs.remove('accessToken');
    }
  }

  bool shouldUpdateLocation(GeoPoint oldLocation, GeoPoint newLocation,
      {double minDistance = 0.05}) {
    final double distance = calculateDistance(
      oldLocation.latitude,
      oldLocation.longitude,
      newLocation.latitude,
      newLocation.longitude,
    );
    return distance > minDistance;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  GeoPoint? _location = GeoPoint(latitude: -7.0, longitude: 110.0);
  GeoPoint? get location => _location;
  set location(GeoPoint? value) {
    if (_location == null ||
        _location!.latitude != value!.latitude ||
        _location!.longitude != value.longitude) {
      // if (kDebugMode) {
      //   print(
      //       '📍 Setter location dipanggil: lat=${value?.latitude}, lon=${value?.longitude}');
      // }
      _location = value;
      notifyListeners();
    }
  }

  double? _speed;
  double? get speed => _speed;
  set speed(double? value) {
    if (_speed != value) {
      _speed = value;
      print(_speed);
      notifyListeners();
    }
  }

  Expression? _expression;
  Expression? get expression => _expression;
  set expression(Expression? value) {
    if (_expression != value) {
      _expression = value;
      notifyListeners();
    }
  }

  bool? _drowsiness;
  bool? get drowsiness => _drowsiness;
  set drowsiness(bool? value) {
    if (_drowsiness != value) {
      _drowsiness = value;
      notifyListeners();
    }
  }

  Future<bool> handleRestrict() async {
    final completer = Completer();
    if (accessToken == null) {
      if (kDebugMode) {
        print("⚠️ Access token is null.");
      }
      completer.complete(false);
    }

    try {
      final response = await http.get(
        _url.replace(path: '/api/auth/restrict'),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Accept": "application/json",
        },
      );

      if (kDebugMode) {
        print("Restrict Response: ${response.statusCode}");
        print("Restrict Body: ${response.body}");
      }

      // Jika token valid, server harus mengembalikan status 200
      if (response.statusCode == 200) {
        completer.complete(true);
      } else {
        // Jika token tidak valid, hapus token
        if (kDebugMode) {
          print("⚠️ Token invalid atau expired. Logging out...");
        }
        await handleLogout();
        completer.complete(false);
      }
    } catch (err) {
      if (kDebugMode) {
        print("❌ Error during restrict check: $err");
      }
      completer.complete(false);
    }
    return await completer.future;
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

  Future<void> handleLogout() async {
    accessToken = null;
  }

  Future<void> eventSourceStream() async {
    try {
      final client = http.Client();
      final req = http.Request(
        'GET',
        _url.replace(path: "/api/device/$deviceId/data/listen"),
      );

      req.headers["Authorization"] = "Bearer $accessToken";

      final http.StreamedResponse rstream = await client.send(req).timeout(
        const Duration(seconds: 15), // Tambahkan timeout
        onTimeout: () {
          if (kDebugMode) {
            print("⚠️ Timeout: Server tidak merespons dalam 15 detik.");
          }
          client.close();
          throw TimeoutException("Server tidak merespons.");
        },
      );

      // Gunakan `asBroadcastStream` agar bisa digunakan ulang
      final stream = rstream.stream.asBroadcastStream();

      stream.listen((onData) {
        try {
          final str = convert.utf8.decode(onData);
          final received = str.split('\n');
          final datastr = received.firstWhere((st) => st.contains('data'));

          final data = convert.json.decode(datastr.replaceFirst('data:', ''))
              as Map<String, dynamic>;

          final double newLatitude = data["latitude"];
          final double newLongitude = data["longitude"];
          final int newSpeed = data["speed"];
          final String newExpression = data["expression"];
          final bool newDrowsiness = data["drowsiness"];

          if (kDebugMode) {
            print('✅ Data diterima: lat=$newLatitude, lon=$newLongitude');
            print('✅ Data diterima: speed=$newSpeed');
            print(
                '✅ Data diterima: exp=$newExpression, drowsiness=$newDrowsiness');
          }

          location = GeoPoint(latitude: newLatitude, longitude: newLongitude);
          speed = newSpeed.toDouble();
          expression = getExpressionFromString(newExpression);
          drowsiness = newDrowsiness;
        } catch (err) {
          if (kDebugMode) {
            print('⚠️ Parsing error: $err');
          }
        }
      }, onError: (error) {
        if (kDebugMode) {
          print("❌ Error saat menerima stream data: $error");
        }
      }, onDone: () {
        if (kDebugMode) {
          print("✅ Stream selesai.");
        }
        client.close(); // Pastikan client ditutup setelah stream selesai
      });
    } catch (err) {
      if (kDebugMode) {
        print("❌ Terjadi error pada stream: $err");
      }
    }
  }
}
