import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/theme/dimensions.dart';
import 'package:bms/core/services/string_format.dart';

class ColoredIconNumberRow extends StatefulWidget {
  final String metric;
  final String mTitle;
  ColoredIconNumberRow(this.metric, this.mTitle);

  @override
  _ColoredIconNumberRowState createState() => _ColoredIconNumberRowState();
}

class _ColoredIconNumberRowState extends State<ColoredIconNumberRow> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);

    var userDocument = snapshot;

    _metric() {
      if (widget.metric == 'total_sales' ||
          widget.metric == 'total_receipts' ||
          widget.metric == 'total_purchases' ||
          widget.metric == 'total_payments') {
        return Text(
          formatIndianCurrency(userDocument["widget.metric"].toString() ?? '0'),
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.normal, color: bmsSuccess),
        );
      } else {
        return Text(
          formatNumber(userDocument[widget.metric].toString() ?? '0'),
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.normal, color: bmsSuccess),
        );
      }
    }

    if (snapshot?.data != null) {
      return Padding(
        padding: spacer.y.xxs,
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Row(
                children: <Widget>[
                  // Icon(
                  //   Icons.arrow_drop_up,
                  //   color: bmsSuccess,
                  //   size: 30.0,
                  // ),
                  _metric(),
                ],
              ),
            ),
            Container(
              child: Text(
                widget.mTitle,
                overflow: TextOverflow.fade,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 12, color: bmsMainText),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}
