import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:bms/core/services/string_format.dart';
import 'package:bms/theme/colors.dart';

class PaymentsDashboardWidget extends StatefulWidget {
  final String? timePeriod;
  PaymentsDashboardWidget({this.timePeriod});

  @override
  _PaymentsDashboardWidgetState createState() =>
      _PaymentsDashboardWidgetState();
}

class _PaymentsDashboardWidgetState extends State<PaymentsDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: PaymentsDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          PaymentsDashboardWidgetContentRow(timePeriod: widget.timePeriod!),
        ],
      ),
    );
  }
}

class PaymentsDashboardWidgetContentRow extends StatefulWidget {
  final String? timePeriod;
  PaymentsDashboardWidgetContentRow({this.timePeriod});

  @override
  _PaymentsDashboardWidgetContentRowState createState() =>
      _PaymentsDashboardWidgetContentRowState();
}

class _PaymentsDashboardWidgetContentRowState
    extends State<PaymentsDashboardWidgetContentRow> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument;
    if (widget.timePeriod == 'Everything') {
      userDocument = snapshot;
    } else {
      userDocument = snapshot[widget.timePeriod!];
    }
    // var userDocument = snapshot?.data;

    if (userDocument != null) {
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Icon(
                    //   Icons.arrow_drop_up,
                    //   color: bmsInfoGrey,
                    // ),
                    Text(
                      formatIndianCurrency(
                              userDocument['total_payments'].toString()) ??
                          '',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: bmsMainText,
                          fontSize: 24,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Text('Total Payments'),
              ],
            ),
            SizedBox(
              width: 100.0,
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Icon(
                    //   Icons.arrow_drop_down,
                    //   color: bmsMainText,
                    // ),
                    Text(
                      userDocument['num_payments_vouchers'].toString() ?? '',
                      style: TextStyle(
                        color: bmsMainText,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Text('Vouchers'),
              ],
            ),
            // SimpleTimeSeriesChart.withSampleData(),
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

class PaymentsDashboardWidgetTitleRow extends StatelessWidget {
  const PaymentsDashboardWidgetTitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument = snapshot;

    void sharePayments(BuildContext context, double payments) {
      final String text =
          "Total Payments is ${userDocument['total_payments']?.toString()}, and total number of vouchers ${userDocument['num_payments_vouchers'].toString()}. - Shared via restat.co/tallyassist.in";

      Share.share(text,
          subject:
              "Total Payments ${userDocument['total_payments'].toString()}");
    }

    if (snapshot.data != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  'Payments',
                  style: TextStyle(
                      color: bmsPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(width: 5.0),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  color: Colors.grey[400],
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Total Payments'),
                        content: Text(
                          'Total Payments is calculated using sum of all Payments. This represents all payments.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        elevation: 24.0,
                        actions: <Widget>[
                          TextButton(
                              child: Text('Ok'),
                              onPressed: () => Navigator.of(context).pop())
                        ],
                      );
                    },
                  ),
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
                IconButton(
                  icon: Icon(Icons.share),
                  color: bmsPrimaryBackground,
                  onPressed: () =>
                      sharePayments(context, userDocument['total_payments']),
                ),
              ],
            ),
          ),
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
