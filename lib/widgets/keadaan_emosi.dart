import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeadaanEmosi extends StatefulWidget {
  const KeadaanEmosi({super.key});
  @override
  State<StatefulWidget> createState() {
    return _KeadaanEmosiState();
  }
}

class _KeadaanEmosiState extends State<KeadaanEmosi> {
  void _openMonitorGraphOverlay() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(50),
        ),
      ),
      builder: (ctx) {
        return Column(
          children: [
            Text(
              'Keadaan Emosi',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Image.asset('assets/images/line_chart.png'),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromRGBO(232, 232, 232, 1),
      width: 172,
      height: 173,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: IconButton(
        onPressed: _openMonitorGraphOverlay,
        icon: Stack(
          children: [
            // Column(
            //   children: [
            //     const SizedBox(
            //       height: 50,
            //     ),
            //     Image.asset('assets/images/line_chart.png'),
            //   ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                  width: 135,
                ),
                Text(
                  'Keadaan Emosi',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
