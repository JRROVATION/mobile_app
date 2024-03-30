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
  final String btDeviceID = "ADVISE";
  // final String btDeviceID = "DESKTOP-31G4UA1"; //Test
  bool isBluetoothOn =
      false; // State untuk mengetahui apakah Bluetooth aktif atau tidak
  bool isPairing = false; // State untuk mengetahui apakah sedang proses pairing
  bool isPaired =
      false; // State untuk mengetahui apakah proses pairing sudah selesai

  bool isBonded = false;

  bool isBTInit = false;

  bool isBTButtonToggled = false;

  String? progressMsg = null;

  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  BluetoothDevice? bluetoothDevice = null;
  StreamSubscription<BluetoothDiscoveryResult>? discoveryStreamSubscription;
  BluetoothConnection? bluetoothConnection = null;

  @override
  void initState() {
    super.initState();
  }

  void toggleBluetooth() async {
    if (isBTButtonToggled) return; //still pressed, cancel

    setState(() {
      isBTButtonToggled = true;
    });

    setProgressMessage("Initializing bluetooth");

    await Future.delayed(const Duration(seconds: 1));

    if (!isBTInit) {
      final initstate = await initBT();
      if (!initstate) {
        print("Init bt failed");
        setProgressMessage("Bluetooth initialization failed");
      } else {
        setState(() {
          isBTInit = true;
        });
      }
    }

    if (isBluetoothOn && isBonded) {
      setState(() {
        isPairing = true;
      });

      setProgressMessage("Pairing");

      final _isPaired = await pairBT();

      if (_isPaired) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(
              bluetoothConnection: bluetoothConnection,
            ),
          ),
        );
      }
    }

    setState(() {
      isBTButtonToggled = false;
    });
  }

  setProgressMessage(String? msg) {
    setState(() {
      progressMsg = msg;
    });
  }

  Future<bool> initBT() async {
    final btstate = await FlutterBluetoothSerial.instance.state;

    print("Bluetooth state : $btstate");

    setState(() {
      bluetoothState = btstate;
      if (btstate == BluetoothState.STATE_ON) isBluetoothOn = true;
    });

    if (!isBluetoothOn) return false;

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

    return true;
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
          setProgressMessage("Device already bonded");
          // is ok, continue
          setState(() {
            isBonded = true;
          });
        } else {
          print(e.message); //other error
        }
      }
    }

    return true;
  }

  Future<bool> pairBT() async {
    if (bluetoothDevice == null) return false;

    try {
      final BluetoothConnection conn =
          await BluetoothConnection.toAddress(bluetoothDevice!.address);

      setState(() {
        bluetoothConnection = conn;
      });
      return true;
    } catch (e) {
      print("Pairing failed : $e");
      setProgressMessage("Pairing failed");
      setState(() {
        isPairing = false;
      });
      return false;
    }
  }

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
                Text("Click to turn bluetooth mode ON"),
                isBonded
                    ? Text("is bonded $btDeviceID")
                    : Text("no bond $btDeviceID"),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    toggleBluetooth();
                  },
                  child: Image.asset(
                    isBTButtonToggled
                        ? 'assets/images/bluetooth_pressed.png'
                        : 'assets/images/bluetooth_button.png',
                    height: 257,
                    width: 257,
                  ),
                ),
                progressMsg != null
                    ? Text("$progressMsg")
                    : SizedBox(
                        height: 10,
                      ),
                // if (isPairing)
                //   Column(
                //     children: [
                //       const SizedBox(height: 10),
                //       Text(
                //         'Pairing to ${bluetoothDevice!.name}...',
                //         style: GoogleFonts.poppins(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ],
                //   ),
                // if (!isPairing && isPaired)
                //   Column(
                //     children: [
                //       const SizedBox(height: 10),
                //       Text(
                //         'Paired',
                //         style: GoogleFonts.poppins(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                // ],
                // ),
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
