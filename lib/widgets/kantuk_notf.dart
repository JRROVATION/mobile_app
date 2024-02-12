import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/condition.dart';

class KantukNotf extends StatefulWidget {
  KantukNotf({
    super.key,
    required this.conditionData,
  });

  ConditionData conditionData;
  @override
  State<KantukNotf> createState() {
    return _KantukNotfState();
  }
}

class _KantukNotfState extends State<KantukNotf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromRGBO(232, 232, 232, 1),
      // width: 173,
      height: 51,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.conditionData.drowsy
                  ? 'Kantuk Terdeteksi'
                  : 'Tidak Kantuk',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Image.asset(
              widget.conditionData.drowsy
                  ? 'assets/images/red.png'
                  : 'assets/images/green.png',
              height: 13,
              width: 13,
            ),
          ],
        ),
      ),
    );
  }
}
