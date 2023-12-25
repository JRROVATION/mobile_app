import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KecepatanNotf extends StatefulWidget {
  const KecepatanNotf({super.key});
  @override
  State<KecepatanNotf> createState() {
    return _KecepatanNotfState();
  }
}

class _KecepatanNotfState extends State<KecepatanNotf> {
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
      // color: const Color.fromRGBO(232, 232, 232, 1),
      width: 173,
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
              'Kecepatan Normal',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Image.asset(
              'assets/images/yellow.png',
              height: 13,
              width: 13,
            ),
          ],
        ),
      ),
    );
  }
}
