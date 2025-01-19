// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';

import 'package:web_socket_client/web_socket_client.dart';
import 'package:args/args.dart';

void main(List<String> aargs) async {
  final parser = ArgParser()..addFlag("is-device", negatable: false, abbr: 'd');

  ArgResults argResults = parser.parse(aargs);

  final isDevice = argResults["is-device"];

  // final addr = Uri.parse('ws://sites.saveforest.cloud:7080');
  // final addr = Uri.parse('ws://localhost:3000');
  final addr = Uri.parse('https://advise.zonainovasi.site/api');

  print("connecting");
  // Create a WebSocket client.
  final socket = WebSocket(addr);

  // Listen to messages from the server.
  socket.messages.listen((message) {
    // Handle incoming messages.
    print(message);
  });

  socket.connection.listen((event) {
    print("state changed : $event");
    if (event is Connected || event is Reconnected) {
      print("connected");
      final clientInfo = {
        "id": "client-info",
        "data": {
          "clientId": "9bb844ce-c4a2-4c3a-abe3-4064f1e5e896",
          "isDevice": isDevice,
        },
      };
      socket.send(jsonEncode(clientInfo));
    }
  });

  await socket.connection.firstWhere((state) => state is Connected);

  if (isDevice) {
    int speed = 0;
    double i = 0.00;
    final timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // Send a message to the server.
      final datatest = {
        "id": "vehicle-data",
        "data": {
          "speed": speed,
          "location": {
            "latitude": -7.55341,
            // "longitude": 103.55213,
          },
          "expression": 0,
          "userId": "9bb844ce-c4a2-4c3a-abe3-4064f1e5e896",
          // "drowsiness": true,
        }
      }; //dummy data
      speed++;
      socket.send(jsonEncode(datatest));
    });
  }
}
