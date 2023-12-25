import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DurasiNotf extends StatefulWidget {
  const DurasiNotf({super.key});
  @override
  State<DurasiNotf> createState() {
    return _DurasiNotfState();
  }
}

class _DurasiNotfState extends State<DurasiNotf> {
  void _openLiveMapOverlay() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (ctx) {
        return const Column(
          children: [],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 173,
      height: 51,
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
              'Durasi Aman',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Image.asset(
              'assets/images/green.png',
              height: 13,
              width: 13,
            ),
          ],
        ),
      ),
    );
  }
}
