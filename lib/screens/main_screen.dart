// ignore_for_file: unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobile_app/model/condition.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/widgets/app_bar.dart';
import 'package:mobile_app/model/sensor.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    this.bluetoothConnection,
  });

  final BluetoothConnection? bluetoothConnection;

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  final int _currentIndex = 0;
  bool isServerConnected = false;

  bool isDriver = false;

  final SensorData sensorData = SensorData();
  final ConditionData conditionData = ConditionData();

  ValueNotifier locationUpdatedNotif = ValueNotifier(false);

  pages() {
    switch (_currentIndex) {
      case 0:
      default:
        return HomeScreen(
          sensorData: sensorData,
          conditionData: conditionData,
          locationUpdatedNotif: locationUpdatedNotif,
          isServerConnected: isServerConnected,
        );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.bluetoothConnection != null) {
      //init all bt functions
      listenBT();

      setState(() {
        isDriver = true;
      });
    }

    initServer();
  }

  void initServer() async {
    if (kDebugMode) {
      print("connecting to server");
    }
    var url = Uri.https('advise.zonainovasi.site', '/api');

    var response = await http.get(url);
    print('GET `/` Response status: ${response.statusCode}');
    // serverSocket = WebSocket(addr);
    // await serverSocket.connection.firstWhere((state) => state is Connected);

    if (kDebugMode) {
      print("Server connected");
    }

    setState(() {
      isServerConnected = true;
    });

    _sendClientInfoToServer();

    // serverSocket.messages.listen((message) {
    //   _handleServerMessage(message);
    // });

    // serverSocket.connection.listen((state) {
    _handleServerConnectionState(response.statusCode);
    // });
  }

  void _sendClientInfoToServer() {
    // ignore: unused_local_variable
    final clientInfo = {
      "id": "client-info",
      "data": {
        "clientId": "0df8a0cc-4269-4147-9541-937ed08a62b7",
        "isDevice": false
      }
    };

    // serverSocket.send(convert.jsonEncode(clientInfo));
  }

  void _handleServerConnectionState(int state) {
    if (kDebugMode) {
      print("Server conn state changed : $state");
    }
    if (state >= 400) {
      isServerConnected = false;
    } else if (state < 400) {
      isServerConnected = true;
      _sendClientInfoToServer();
    }

    setState(() {
      isServerConnected;
    });
  }

  void _handleServerMessage(message) {
    if (kDebugMode) {
      print("received from server $message");
    }
    final data = convert.jsonDecode(message);

    _handleMessageData(data);
  }

  void _sendToServer(String message) {
    // serverSocket.send(message);
  }

  void _onReceivedBT(payload) {
    String message = String.fromCharCodes(payload);
    if (kDebugMode) {
      print("received from bt : $message");
    }
    final data = convert.jsonDecode(message);

    if (kDebugMode) {
      print("received from bt ID : ${data["id"]}");
    }

    _handleMessageData(data);
  }

  void _sendBT(payload) {
    widget.bluetoothConnection!.output.add(payload);
    widget.bluetoothConnection!.output.allSent.then((value) {
      if (kDebugMode) {
        print("send to bt success");
      }
      Future.delayed(const Duration(seconds: 3), () {
        final ll = 'hello\r\n'.codeUnits;
        _sendBT(Uint8List.fromList(ll));
      });
    });
  }

  void listenBT() async {
    final ll = 'hello\r\n'.codeUnits;
    _sendBT(Uint8List.fromList(ll));

    widget.bluetoothConnection!.input!.listen((event) {
      _onReceivedBT(event);
    });
  }

  void _handleMessageData(data) {
    switch (data["id"]) {
      case "vehicle-data":
        if (data["speed"] != null) {
          if (kDebugMode) {
            print("speed : ${data["speed"]}");
          }
          setState(() {
            sensorData.speed = data["speed"] + 0.0;
          });
        }

        if (data["drowsiness"] != null) {
          if (kDebugMode) {
            print("drowsiness : ${data["drowsiness"]}");
          }
          setState(() {
            conditionData.drowsy = data["drowsiness"];
          });
        }

        if (data["expression"] != null) {
          if (kDebugMode) {
            print("expression : ${data["expression"]}");
          }
          setState(() {
            conditionData.expression = Expression.values[data["expression"]];
          });
        }

        if (data["latitude"] != null && data["longitude"] != null) {
          if (kDebugMode) {
            print('${data["latitude"]} ${data["longitude"]}');
          }
          setState(() {
            sensorData.location = Location(
              latitude: data["latitude"] + 0.0,
              longitude: data["longitude"] + 0.0,
            );
          });

          locationUpdatedNotif.value = !locationUpdatedNotif.value;
        }

        //if device is driver, send sensor data to server
        if (isDriver) {
          data["id"] = "post-sensor"; //change msg id to post
          _sendToServer(convert.jsonEncode(data));
        }
        break;

      default:
        if (kDebugMode) {
          print("unhandled msg ID");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(currentIndex: _currentIndex),
      body: pages(),
    );
  }
}
