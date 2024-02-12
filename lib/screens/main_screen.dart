import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int _currentIndex = 0;

  final SensorData sensorData = SensorData();
  final ConditionData conditionData = ConditionData();

  Pages() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen(
          sensorData: sensorData,
          conditionData: conditionData,
        );
      default:
        return HomeScreen(
          sensorData: sensorData,
          conditionData: conditionData,
        );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.bluetoothConnection != null) {
      //init all bt functions
      listenBT();
    }
  }

  void _onReceivedBT(payload) {
    String message = String.fromCharCodes(payload);
    print("received from bt : $message");
    final data = convert.jsonDecode(message);

    print("received from bt ID : ${data["id"]}");

    switch (data["id"]) {
      case "get-sensor":
        if (data["speed"] != null) {
          print(data["speed"]);
          setState(() {
            sensorData.speed = data["speed"] + 0.0;
          });
        }

        if (data["location"] != null) {
          print(data["location"]);
          setState(() {
            sensorData.location = Location(
              latitude: data["location"]["latitude"] + 0.0,
              longitude: data["location"]["longitude"] + 0.0,
            );
          });
        }
        break;
      default:
        print("unhandled msg ID");
        break;
    }
  }

  void _sendBT(payload) {
    widget.bluetoothConnection!.output.add(payload);
    widget.bluetoothConnection!.output.allSent.then((value) {
      print("send to bt success");
      Future.delayed(Duration(seconds: 3), () {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(currentIndex: _currentIndex),
      body: Pages(),
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
