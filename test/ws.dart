import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:web_socket_client/web_socket_client.dart';
import 'package:args/args.dart';

void main(List<String> aargs) async {
  final parser = ArgParser()..addFlag("is-driver", negatable: false, abbr: 'd');

  ArgResults argResults = parser.parse(aargs);

  final isDriver = argResults["is-driver"];

  final addr = Uri.parse('ws://sites.saveforest.cloud:7080');
  // final addr = Uri.parse('ws://localhost:3000');
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
        "isDriver": isDriver,
      };
      socket.send(jsonEncode(clientInfo));
    }
  });

  await socket.connection.firstWhere((state) => state is Connected);

  if (isDriver) {
    int speed = 0;
    double i = 0.00;
    final timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Send a message to the server.
      final datatest = {
        "id": "post-sensor",
        "speed": speed,
        "location": {
          "latitude": -7.0 + (i += 0.001),
          "longitude": 110.0,
        },
        "expression": 0,
        // "drowsiness": true,
      }; //dummy data
      speed++;
      socket.send(jsonEncode(datatest));
    });
  }
}
