import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_screen.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class BluetoothPairing extends StatefulWidget {
  const BluetoothPairing({Key? key}) : super(key: key);

  @override
  _BluetoothPairingState createState() => _BluetoothPairingState();
}

class _BluetoothPairingState extends State<BluetoothPairing> {
  // final String btDeviceID = "ADVISE";
  final String btDeviceID = "DESKTOP-31G4UA1"; //Test
  bool isBluetoothOn =
      false; // State untuk mengetahui apakah Bluetooth aktif atau tidak
  bool isPairing = false; // State untuk mengetahui apakah sedang proses pairing
  bool isPaired =
      false; // State untuk mengetahui apakah proses pairing sudah selesai

  bool isBonded = false;

  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice? bluetoothDevice = null;
  StreamSubscription<BluetoothDiscoveryResult>? discoveryStreamSubscription;

  void toggleBluetooth() async {
    // setState(() {
    // isBluetoothOn = !isBluetoothOn;
    if (isBluetoothOn && isBonded) {
      isPairing = true;
      await pairBT();
      // Future.delayed(const Duration(seconds: 3), () {
      //   setState(() {
      //     isPairing = false;
      //     isPaired = true; // Setelah proses pairing selesai
      //   });
      //   if (isPaired) {
      //     Future.delayed(const Duration(seconds: 1), () {
      //       // Navigasi ke MainScreen setelah proses pairing selesai
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (context) => MainScreen(),
      //         ),
      //       );
      //     });
      //   }
      // });
    }
    // });
  }

  @override
  void initState() {
    super.initState();

    initBT();
  }

  void initBT() async {
    FlutterBluetoothSerial.instance.state.then((state) {
      print("Bluetooth state : $state");

      setState(() {
        bluetoothState = state;
        if (state == BluetoothState.STATE_ON) isBluetoothOn = true;
      });
    });

    if (await Permission.bluetooth.isDenied) {
      await Permission.bluetooth.request();
    }

    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }

    if (await Permission.bluetoothScan.isDenied) {
      await Permission.bluetoothScan.request();
    }

    // Check if ADVISE device already in bonded list

    final bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();

    bondedDevices.forEach((element) {
      if (element.name == btDeviceID) {
        //ready to pair
        setState(() {
          bluetoothDevice = element;
          isBonded = true;
        });
      }
    });

    if (!isBonded) {
      await findBTDevice();
    }

    if (isBonded) {
      print("ready to pel");
    }
  }

  Future<bool> findBTDevice() async {
    // If not bonded, start discovery, and bond
    final st = FlutterBluetoothSerial.instance.startDiscovery();
    final discovered = await st.toList();

    BluetoothDevice? founddevice = null;

    discovered.forEach((element) {
      print("Discovered : ${element.device.name}");
      founddevice = element.device;
    });

    if (founddevice == null) return false;

    BluetoothDevice device = founddevice!;

    setState(() {
      bluetoothDevice = device;
    });

    if (device.name == btDeviceID) {
      try {
        final bondstatus = await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(device.address);

        if (bondstatus == null) {
          print("bondstatus is null");
        } else {
          print("bondstatus $bondstatus");
          if (bondstatus) {
            // is ok, continue
            setState(() {
              isBonded = true;
            });
          }
        }
      } on PlatformException catch (e) {
        print(e);
        if (e.message == "device already bonded") {
          print("device already bonded");
          // is ok, continue
        } else {
          print(e.message); //other error
        }
      }
    }

    return true;
  }

  Future<bool> pairBT() async {
    if (bluetoothDevice == null) return false;

    final BluetoothConnection conn =
        await BluetoothConnection.toAddress(bluetoothDevice!.address);

    conn.input!.listen((event) {
      String s = String.fromCharCodes(event);
      print("received from ${bluetoothDevice!.name} : $s");
    });

    return true;
  }

  // void _onDataReceived(Uint8List data) {
  //   data.forEach((d) {
  //     print("received : ");
  //     print(d);
  //   });
  //   String s = new String.fromCharCodes(data);
  //   print(s);
  //   setState(() {
  //     _message = s;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bluetooth Pair",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    toggleBluetooth();
                  },
                  child: Image.asset(
                    !isBluetoothOn
                        ? 'assets/images/bluetooth_pressed.png'
                        : 'assets/images/bluetooth_button.png',
                    height: 257,
                    width: 257,
                  ),
                ),
                if (isPairing)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Pairing...',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                if (!isPairing && isPaired)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'Paired',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              },
              child: Text(
                'Skip >>>',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
