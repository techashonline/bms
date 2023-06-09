import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/core/services/string_format.dart';
import 'package:bms/ui/shared/positiveamount.dart';

class OutstandingsDashboardWidget extends StatelessWidget {
  final String? timePeriod;
  OutstandingsDashboardWidget({this.timePeriod});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: OutstandingsDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          OutstandingsDashboardWidgetContentRow(
            timePeriod: this.timePeriod!,
          ),
        ],
      ),
    );
  }
}

class OutstandingsDashboardWidgetContentRow extends StatelessWidget {
  final String? timePeriod;
  OutstandingsDashboardWidgetContentRow({this.timePeriod});

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument;
    if (this.timePeriod == 'Everything') {
      userDocument = snapshot;
    } else {
      userDocument = snapshot[this.timePeriod!];
    }

    if (userDocument != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              // Text(' '),
              Text('Payables',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: bmsPrimary)),
              Text('Receivables',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: bmsPrimary)),
            ],
          ),
          // Column(
          //   children: <Widget>[
          //     Text('Target'),
          //     Text(userDocument['out_target_pay'].toString()),
          //     Text(userDocument['out_target_rec'].toString())
          //   ],
          // ),
          Column(
            children: <Widget>[
              // Text('Actual'),
              Text(
                formatIndianCurrency(
                    positiveAmount(userDocument['out_actual_pay'])),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: bmsMainText),
              ),
              Text(
                formatIndianCurrency(userDocument['out_actual_rec'].toString()),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: bmsMainText),
              ),
            ],
          ),
          // Column(
          //   children: <Widget>[
          //     Text('Avg. Delay'),
          //     Text(
          //       userDocument['out_avgdel_pay'].toString(),
          //       style: Theme.of(context).textTheme.body1.copyWith(
          //         color: bmsWarning
          //       ),
          //     ),
          //     Text(
          //       userDocument['out_avgdel_rec'].toString(),
          //       style: Theme.of(context).textTheme.body1.copyWith(
          //         color: bmsSuccess
          //       ),
          //     ),
          //   ],
          // ),
        ],
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

class OutstandingsDashboardWidgetTitleRow extends StatelessWidget {
  const OutstandingsDashboardWidgetTitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Outstandings',
                style: TextStyle(
                    color: bmsPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              // Icon(
              //   Icons.favorite,
              //   color: bmsPrimaryBackground,
              // ),
              // Icon(
              //   Icons.bookmark,
              //   color: bmsPrimaryBackground,
              // ),
              Icon(
                Icons.share,
                color: bmsPrimaryBackground,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
