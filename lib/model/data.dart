class Data {
  Data({
    required this.kecepatan,
    required this.avgkecepatan,
    required this.jarak,
    required this.makskecepatan,
    required this.latitude,
    required this.longitude,
    required this.emosi,
    required this.hujan,
    required this.kantuk,
    required this.jumlahberhenti,
    required this.durasi,
    required this.totaldurasi
  });

  String emosi;
  double latitude;
  double longitude;
  double kecepatan;
  bool kantuk;
  bool hujan;
  double avgkecepatan;
  double jarak;
  double makskecepatan;
  int jumlahberhenti;
  String durasi;
  String totaldurasi;
}
