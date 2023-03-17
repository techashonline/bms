import 'package:flutter/material.dart';
import 'package:bms/theme/colors.dart';

BoxDecoration myBoxDecorationTopBorder() {
  return BoxDecoration(
    border: Border(
      top: BorderSide(
        //                    <--- top side
        color: Colors.blueGrey,
        width: 3.0,
      ),
    ),
  );
}

BoxDecoration myBoxDecorationBottomBorder() {
  return BoxDecoration(
    // border: Border(
    //   bottom: BorderSide(
    //     color: Colors.blueGrey,
    //     width: 3.0,
    //   ),
    // ),
    color: bmsBgLightPurple,
    shape: BoxShape.rectangle,
  );
}
