import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/provider.dart';
import 'package:mobile_app/view_models/advise_view_model.dart';

class KecepatanSensor extends StatefulWidget with GetItStatefulWidgetMixin {
  KecepatanSensor({
    super.key,
  });

  @override
  State<KecepatanSensor> createState() {
    return _KecepatanSensorState();
  }
}

class _KecepatanSensorState extends State<KecepatanSensor>
    with GetItStateMixin {
  late AdviseViewModel model;
  // double? speed;
  @override
  void initState() {
    model = locator<AdviseViewModel>();
    super.initState();
  }

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
        return Container(
          width: double.infinity,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double speed = watchOnly((AdviseViewModel only) => only.speed ?? 0);
    return Container(
      // color: const Color.fromRGBO(232, 232, 232, 1),
      width: 362,
      height: 87,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(232, 232, 232, 1),
      ),
      child: IconButton(
        onPressed: _openLiveMapOverlay,
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  Text(
                    'Kecepatan',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '$speed',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 0.0, 15.0, 20.0),
                        child: Text(
                          'km/j',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
