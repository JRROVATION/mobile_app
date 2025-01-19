import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.https('advise.zonainovasi.site', '/api');
  String? accessToken;
  var deviceId = "0df8a0cc-4269-4147-9541-937ed08a62b7";

  {
    // Test GET
    var response = await http.get(url);
    print('GET `/` Response status: ${response.statusCode}');
  }
  {
    // Test Restrict
    url.replace(path: '/api/auth/restrict');
    var response = await http.get(
      url.replace(path: '/api/auth/restrict'),
      headers: {"Authorization": "Bearer $accessToken"},
    );

    print('Restrict `/` Response status: ${response.statusCode}');
  }

  {
    // Sign in
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final payload = convert.json.encode({
      "username": "advise_device",
      "password": "advise123",
    });

    var response = await http.post(
      url.replace(path: '/api/auth/sign-in'),
      headers: headers,
      body: payload,
    );
    print('POST `/api/auth/sign-in` Response status: ${response.statusCode}');
    final receive = convert.json.decode(response.body);
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    accessToken = jsonResponse["access_token"];
    print(jsonResponse["user"]['id']);
  }

  {
    //Event source stream
    final client = http.Client();

    final req = http.Request(
      'GET',
      url.replace(path: "/api/device/$deviceId/data/listen"),
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
        double latitude = data["latitude"];
        double longitude = data["longitude"];
        int speed = data["speed"];
        String expression = data["expression"];
        bool drowsiness = data["drowsiness"];

        print("Latitude: $latitude");
        print("Longitude: $longitude");
        print("Speed: $speed");
        print("Expression: $expression");
        print("Drowsiness: $drowsiness");
      } catch (err) {
        print('error: $err');
      }
    });
  }
}
