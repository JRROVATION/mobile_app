import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/condition.dart';

class KeadaanEmosi extends StatefulWidget {
  KeadaanEmosi({
    super.key,
    required this.conditionData,
  });

  ConditionData conditionData;

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
        return Container(
          width: double.infinity,
          child: Column(
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
          ),
        );
      },
    );
  }

  EmotionImage() {
    return Image.asset(
      "assets/images/emot_${GetExpressionString(widget.conditionData.expression)}.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromRGBO(232, 232, 232, 1),
      // width: 50,
      // height: 173,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: IconButton(
        onPressed: _openMonitorGraphOverlay,
        icon: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keadaan Emosi',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Ekspresi',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(20),
                  child: EmotionImage(),
                ),
                Text(
                  GetExpressionStateStringID(widget.conditionData.expression),
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
    );
  }
}
