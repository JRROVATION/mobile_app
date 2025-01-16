import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.https('advise.zonainovasi.site', '/');
  var access_token = null;
  var device_id = "c811f5a1-dbc1-4407-a429-699a49a00508";

  {
    // Test GET
    var response = await http.get(url);
    print('GET `/` Response status: ${response.statusCode}');
  }

  {
    // Sign in
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final payload = json.encode({
      "username": "diandrary",
      "password": "theunrarizqy",
    });

    var response = await http.post(
      url.replace(path: '/auth/sign-in'),
      headers: headers,
      body: payload,
    );
    print('POST `/auth/sign-in` Response status: ${response.statusCode}');
    final receive = json.decode(response.body);
    access_token = receive["access_token"];
  }

  {
    //Event source stream
    final client = http.Client();

    final req = http.Request(
      'GET',
      url.replace(path: "/device/$device_id/data/listen"),
    );

    req.headers.putIfAbsent("Authorization", () => "Bearer ${access_token}");

    final http.StreamedResponse rstream = await client.send(req);

    rstream.stream.listen((onData) {
      try {
        final str = utf8.decode(onData);
        final received = str.split('\n');
        final datastr = received.firstWhere((st) => st.contains('data'));

        final data = json.decode(datastr.replaceFirst('data:', ''));

        print(data);
      } catch (err) {
        print(err);
      }
    });
  }
}
