import 'dart:convert';

import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.http('10.8.0.5:5555', '/');
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');

  final client = http.Client();

  final http.StreamedResponse rstream =
      await client.send(http.Request('GET', url.replace(path: '/sse')));

  rstream.stream.listen((onData) {
    final str = utf8.decode(onData);

    // print(str);

    final datas = str.split('\n');

    var id = datas[0].split(':').last;
    var data = datas[1].split('data:').last;

    try {
      final j = jsonDecode(data);

      print("id : $id\ndata : $j");
    } on FormatException {
      print("Format Exception");
    }
  });
}
