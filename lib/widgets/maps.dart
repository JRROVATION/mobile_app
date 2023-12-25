import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapsLocation extends StatefulWidget {
  const MapsLocation({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MapsLocationState();
  }
}

class _MapsLocationState extends State<MapsLocation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 362,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
    );
  }
}
