import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/model/data_latest.dart';
import 'package:mobile_app/model/data.dart';
import 'package:mobile_app/widgets/keadaan_emosi.dart';
import 'package:mobile_app/widgets/berkendara_notf.dart';
import 'package:mobile_app/widgets/kantuk_notf.dart';
import 'package:mobile_app/widgets/kecepatan_sensor.dart';
import 'package:mobile_app/widgets/maps.dart';
import 'package:mobile_app/widgets/kecepatan_notf.dart';
import 'package:mobile_app/widgets/rincian_sensor.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

final formatter = DateFormat.yMMMMEEEEd();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Data> _data = [];
  final now = DateTime.now();
  final LatestData _apiData = LatestData(
    kecepatan: 0,
    avgkecepatan: 0,
    jarak: 0,
    makskecepatan: 0,
    latitude: -7.767613250596083,
    longitude: 110.37651217050859,
    emosi: '',
    hujan: false,
    kantuk: false,
    jumlahberhenti: 0,
    durasi: "",
    totaldurasi: "",
  );

  @override
  void initState() {
    super.initState();
    _data.add(Data(
      kecepatan: 0,
      avgkecepatan: 0,
      jarak: 0,
      makskecepatan: 0,
      latitude: -7.767613250596083,
      longitude: 110.37651217050859,
      emosi: '',
      hujan: false,
      kantuk: false,
      jumlahberhenti: 0,
      durasi: "",
      totaldurasi: "",
    ));
    _loadApiData();
    _loadSensorData();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        _loadApiData();
        _loadData();
      }
    });
  }

  void _loadData() async {
    final url = Uri.http('iwms.site:9898', '/api', {
      "id": "data",
      "type": "get",
    });
    final response = await http.get(url);
    if (response.statusCode > 400) {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
    if (response.body == 'null') {
      return;
    }
    _loadSensorData();
  }

  void _loadSensorData() async {
    final url = Uri.http('iwms.site:9898', '/api', {
      "id": "data",
      "type": "get",
    });
    final response = await http.get(url);
    if (response.statusCode > 400) {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
    if (response.body == 'null') {
      return;
    }
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    _data.clear();
    print('pppppppppppppppppppppppppppppppppp');
    for (final item in jsonResponse['message']) {
      print('pressure: ${item['id']}');
      setState(() {
        _data.add(
          Data(
            emosi: item['emosi'],
            kantuk: item['kantuk'],
            hujan: item['hujan'],
            kecepatan: item['kecepatan'],
            avgkecepatan: item['kecepatan_rata2'],
            makskecepatan: item['kecepatan_max'],
            durasi: item['durasi_perjalanan'],
            totaldurasi: item['durasi_total'],
            jarak: item['jarak'],
            jumlahberhenti: item['jumlah_pemberhentian'],
            latitude: item['latitude'],
            longitude: item['longitude'],
          ),
        );
      });
    }
  }

  void _loadApiData() async {
    var url = Uri.http('iwms.site:9898', '/api', {
      'id': "data",
      'type': "get",
    });
    final response = await http.get(url);
    if (response.statusCode > 400) {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
    if (response.body == 'null') {
      return;
    }
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    if (mounted) {
      setState(() {
        _apiData.emosi = jsonResponse['message']['emosi'];
        _apiData.kantuk = jsonResponse['message']['kantuk'];
        _apiData.hujan = jsonResponse['message']['hujan'];
        _apiData.kecepatan = jsonResponse['message']['kecepatan']+ 0.0;
        _apiData.avgkecepatan =
            jsonResponse['message']['kecepatan_rata2'] + 0.0;
        _apiData.makskecepatan = jsonResponse['message']['kecepatan_max'] + 0.0;
        _apiData.durasi = jsonResponse['message']['durasi_perjalanan'];
        _apiData.durasi = jsonResponse['message']['durasi_total'];
        _apiData.jarak = jsonResponse['message']['jarak'] + 0.0;
        _apiData.jumlahberhenti =
            jsonResponse['message']['jumlah_pemberhentian'] + 0;
        _apiData.latitude = jsonResponse['message']['latitude'] + 0.0;
        _apiData.longitude = jsonResponse['message']['longitude'] + 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = formatter.format(now);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 47 / 2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Pagi',
                        style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Senin, 25 Desember 2023',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const MapsLocation(),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KeadaanEmosi(apiData: _apiData),
                    const SizedBox(
                      width: 15,
                    ),
                    const Column(
                      children: [
                        KantukNotf(),
                        SizedBox(
                          height: 7,
                        ),
                        DurasiNotf(),
                        SizedBox(
                          height: 7,
                        ),
                        KecepatanNotf(),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                KecepatanSensor(apiData: _apiData),
                const SizedBox(
                  height: 17,
                ),
                const RincianSensor(),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
