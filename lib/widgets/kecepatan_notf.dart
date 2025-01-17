import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class KecepatanNotf extends StatefulWidget with GetItStatefulWidgetMixin {
  KecepatanNotf({
    super.key,
  });

  @override
  State<KecepatanNotf> createState() => _KecepatanNotfState();
}

class _KecepatanNotfState extends State<KecepatanNotf> with GetItStateMixin {
  final model = locator<AdviseViewModel>();

  // void _openLiveMapOverlay() {
  //   showModalBottomSheet(
  //     context: context,
  //     showDragHandle: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(50),
  //       ),
  //     ),
  //     builder: (ctx) {
  //       return const Column(
  //         children: [],
  //       );
  //     },
  //   );
  // }

  statusKecepatanString() {
    String speedString = "";
    double speed = model.speed ?? 0;
    if (speed > 70) {
      speedString = "Tinggi";
    } else if (speed > 50) {
      speedString = "Normal";
    } else {
      speedString = "Rendah";
    }
    return "Kecepatan $speedString";
  }

  @override
  Widget build(BuildContext context) {
    watchOnly((AdviseViewModel only) => only.speed);
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
              statusKecepatanString(),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Image.asset(
              (model.speed ?? 0) > 70
                  ? 'assets/images/red.png'
                  : (model.speed ?? 0) > 50
                      ? 'assets/images/yellow.png'
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
