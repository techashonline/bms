import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:bms/core/services/string_format.dart';
import 'package:bms/theme/colors.dart';

class PurchasesDashboardWidget extends StatefulWidget {
  final String? timePeriod;
  PurchasesDashboardWidget({this.timePeriod});

  @override
  _PurchasesDashboardWidgetState createState() =>
      _PurchasesDashboardWidgetState();
}

class _PurchasesDashboardWidgetState extends State<PurchasesDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: PurchasesDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          PurchasesDashboardWidgetContentRow(timePeriod: widget.timePeriod!),
        ],
      ),
    );
  }
}

class PurchasesDashboardWidgetContentRow extends StatefulWidget {
  final String? timePeriod;
  PurchasesDashboardWidgetContentRow({this.timePeriod});

  @override
  _PurchasesDashboardWidgetContentRowState createState() =>
      _PurchasesDashboardWidgetContentRowState();
}

class _PurchasesDashboardWidgetContentRowState
    extends State<PurchasesDashboardWidgetContentRow> {
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
                              userDocument['total_purchases'].toString()) ??
                          '',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: bmsMainText,
                          fontSize: 24,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Text('Total Purchases'),
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
                      userDocument['num_purchase_vouchers'].toString() ?? '',
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

class PurchasesDashboardWidgetTitleRow extends StatelessWidget {
  const PurchasesDashboardWidgetTitleRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument = snapshot;

    void sharePurchases(BuildContext context, double purchases) {
      final String text =
          "Total Purchases is ${userDocument['total_purchases'].toString()}, and total number of vouchers ${userDocument['num_purchases_vouchers'].toString()}. - Shared via restat.co/tallyassist.in";

      Share.share(text,
          subject:
              "Total Purchases ${userDocument['total_purchases'].toString()}");
    }

    if (snapshot?.data != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  'Purchases',
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
                        title: Text('Total Purchases'),
                        content: Text(
                          'Total Purchases is calculated using sum of all Purchase Vouchers. This represents Gross Purcahses, no Debit notes are deducted.',
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
                      sharePurchases(context, userDocument['total_purchases']),
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
