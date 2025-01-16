import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:mobile_app/model/condition.dart';
import 'package:mobile_app/screens/home.dart';
import 'package:mobile_app/widgets/app_bar.dart';
import 'package:mobile_app/model/sensor.dart';

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

  late final WebSocket serverSocket;

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
    final addr = Uri.parse('ws://theunra.site:3001');

    if (kDebugMode) {
      print("connecting to server");
    }

    serverSocket = WebSocket(addr);
    await serverSocket.connection.firstWhere((state) => state is Connected);

    if (kDebugMode) {
      print("Server connected");
    }

    setState(() {
      isServerConnected = true;
    });

    _sendClientInfoToServer();

    serverSocket.messages.listen((message) {
      _handleServerMessage(message);
    });

    serverSocket.connection.listen((state) {
      _handleServerConnectionState(state);
    });
  }

  void _sendClientInfoToServer() {
    final clientInfo = {
      "id": "client-info",
      "data": {
        "clientId": "9bb844ce-c4a2-4c3a-abe3-4064f1e5e896",
        "isDevice": false
      }
    };

    serverSocket.send(convert.jsonEncode(clientInfo));
  }

  void _handleServerConnectionState(state) {
    if (kDebugMode) {
      print("Server conn state changed : $state");
    }
    if (state is Disconnected || state is Reconnecting) {
      isServerConnected = false;
    } else if (state is Connected || state is Reconnected) {
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
    serverSocket.send(message);
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
      // bottomNavigationBar: const SizedBox(
      //   height: 83,
      // child: BottomNavigationBar(
      //   backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: 'ATHUS',
      //       icon: Icon(
      //         Icons.water_drop_outlined,
      //       ),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'MMS',
      //       icon: Icon(Icons.air_outlined),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'TMA',
      //       icon: Icon(Icons.water_outlined),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Air',
      //       icon: Icon(Icons.water),
      //     ),
      //   ],
      //   selectedLabelStyle: GoogleFonts.poppins(
      //     fontWeight: FontWeight.bold,
      //     fontSize: 10,
      //   ),
      //   unselectedLabelStyle: GoogleFonts.poppins(
      //     // fontWeight: FontWeight.w500,
      //     fontSize: 10,
      //   ),
      //   selectedItemColor: Colors.black,
      //   unselectedItemColor: Colors.grey.shade700,
      // ),
      // ),
    );
  }
}
