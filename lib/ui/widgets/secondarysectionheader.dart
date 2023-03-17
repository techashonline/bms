import 'package:flutter/material.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/theme/dimensions.dart';

class SecondarySectionHeader extends StatelessWidget {
  final sectionText;

  SecondarySectionHeader(this.sectionText);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bmsBgLightPurple,
        padding: spacer.x.xs,
        child: Text(sectionText,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.bold)));
  }
}
