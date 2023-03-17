import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/services/database.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/ui/views/vouchers.dart';
import 'package:bms/ui/widgets/coloredIcon.dart';
import 'package:bms/ui/widgets/gotobar.dart';
import 'package:bms/ui/widgets/inactivecustomerlist.dart';
import 'package:bms/ui/widgets/secondarysectionheader.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class SalesOrderReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot?>.value(
            value: DatabaseService(uid: user?.uid)
                .metricCollection
                .doc(user.uid)
                .snapshots(),
            initialData: null,
          ),
        ],
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: _drawerKey,
            drawer: bmsDrawer(context),
            appBar: headerNav(_drawerKey),
            // bottomNavigationBar: bottomNav(),
            body: ListView(
              children: <Widget>[
                SectionHeader('Sales Report'),
                // Container(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Expanded(
                //         child: Container(
                //           padding: spacer.x.xs,
                //           margin: spacer.all.xxs,
                //           color: bmsBgBlue,
                //           child: Row(
                //             children: <Widget>[
                //               Text('Product'),
                //               Icon(Icons.arrow_drop_down,
                //                   color: Colors.purple[800]),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Container(
                //           padding: spacer.x.xs,
                //           margin: spacer.all.xxs,
                //           color: bmsBgBlue,
                //           child: Row(
                //             children: <Widget>[
                //               Text('Customer'),
                //               Icon(Icons.arrow_drop_down,
                //                   color: Colors.purple[800]),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ColoredIconNumberRow('total_sales', 'Amount Sold'),
                        // ColoredIconNumberRow('open_sales_orders', 'Open Orders'),
                        ColoredIconNumberRow(
                            'num_sales_vouchers', '# Vouchers'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        // ColoredIconNumberRow('qty_sales_order', 'Ordered Qty'),
                        // ColoredIconNumberRow('qty_sales_due', 'Quantity Due'),
                        ColoredIconNumberRow(
                            'total_receipts', 'Total Receipts'),
                        ColoredIconNumberRow(
                            'num_receipts_vouchers', '# Vouchers'),
                      ],
                    )
                  ],
                ),
                // FilterBar('Sales Vouchers By', 'Due Date'),
                GoToBar('Sales Vouchers', VouchersHome()),
                // SalesVoucherList(),

                SecondarySectionHeader('Inactive Customer List'),

                InactiveCustomerList()
              ],
            ),
          ),
        ));
  }
}
