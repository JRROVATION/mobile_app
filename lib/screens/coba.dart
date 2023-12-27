import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://iwms.site:9898/api'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request Example'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Proses dan tampilkan data sesuai kebutuhan Anda
            Map<String, dynamic> data = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Kantuk: ${data['message']['kantuk']}'),
                Text('Emosi: ${data['message']['emosi']}'),
                Text('Kecepatan: ${data['message']['kecepatan']}'),
                Text('Latitude: ${data['message']['lokasi']['latitude']}'),
                Text('Longitude: ${data['message']['lokasi']['longitude']}'),
              ],
            );
          }
        },
      ),
    );
  }
}
