import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class KantukNotf extends StatefulWidget with GetItStatefulWidgetMixin {
  KantukNotf({
    super.key,
  });

  @override
  State<KantukNotf> createState() {
    return _KantukNotfState();
  }
}

class _KantukNotfState extends State<KantukNotf> with GetItStateMixin {
  final model = locator<AdviseViewModel>();

  @override
  Widget build(BuildContext context) {
    watchOnly((AdviseViewModel only) => only.drowsiness);
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
              model.drowsiness ?? false ? 'Kantuk Terdeteksi' : 'Tidak Kantuk',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            Image.asset(
              model.drowsiness ?? false
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
