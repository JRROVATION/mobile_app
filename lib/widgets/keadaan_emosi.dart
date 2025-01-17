import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/model/condition.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class KeadaanEmosi extends StatefulWidget with GetItStatefulWidgetMixin {
  KeadaanEmosi({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _KeadaanEmosiState();
  }
}

class _KeadaanEmosiState extends State<KeadaanEmosi> with GetItStateMixin {
  final model = locator<AdviseViewModel>();

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
        return SizedBox(
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

  emotionImage() {
    return Image.asset(
      "assets/images/emot_${getExpressionString(model.expression ?? Expression.neutral)}.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    watchOnly((AdviseViewModel only) => only.expression);
    return Container(
      // color: const Color.fromRGBO(232, 232, 232, 1),
      // width: 50,
      // height: 173,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  padding: const EdgeInsets.all(20),
                  child: emotionImage(),
                ),
                Text(
                  getExpressionStateStringID(
                      model.expression ?? Expression.neutral),
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
