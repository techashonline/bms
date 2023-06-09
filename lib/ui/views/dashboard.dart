// Pending issue - dropdown widget not displaying value

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/services/database.dart';
import 'package:bms/core/services/timeperiod_filter_service.dart';
import 'package:bms/theme/theme.dart';
// import 'package:bms/theme/colors.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/ui/views/accountspayablescreen.dart';
import 'package:bms/ui/views/accountsreceivables.dart';
import 'package:bms/ui/views/pruchaseorderreport.dart';
import 'package:bms/ui/views/salesorderreport.dart';
import 'package:bms/ui/views/vouchers.dart';
import 'package:bms/ui/widgets/dashboardScreens/Purchases.dart';
// import 'package:bms/ui/widgets/dashboardScreens/expenses.dart';
import 'package:bms/ui/widgets/dashboardScreens/payments.dart';
import 'package:bms/ui/widgets/dashboardScreens/receipts.dart';
import 'package:bms/ui/widgets/dashboardScreens/sales.dart';
import 'package:bms/ui/widgets/gotobar.dart';
// import 'package:bms/ui/widgets/dashboardScreens/cash.dart';
import 'package:bms/ui/widgets/dashboardScreens/outstanding.dart';
import 'package:bms/ui/widgets/myboxdecoration.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({this.userId}) : super();

  final String? userId;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String timePeriod = 'Everything';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    print(timePeriod);

    return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot?>.value(
            value: DatabaseService().metricCollection.doc(user.uid).snapshots(),
            initialData: null,
          ),
        ],
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: _drawerKey,
            appBar: headerNav(_drawerKey),
            drawer: bmsDrawer(context),
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                      child: Text(
                        'Your Tally is Connected!',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    color: const Color(0xff14D2B8),
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                  ),
                  // Container 0 - Timeperiod picker
                  Container(
                    decoration: myBoxDecorationBottomBorder(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Select timeperiod",
                            style: secondaryListTitle2,
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.av_timer),
                            onSelected: (value) {
                              setState(() {
                                timePeriod = value;
                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return timePeriodList.map(
                                (String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(
                                      choice,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0),
                                    ),
                                  );
                                },
                              ).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                    // color: Colors.blueGrey[100],
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                  ),
                  // Container 1 - Sales
                  Container(
                    child: SalesDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Sales', SalesOrderReportScreen()),
                  // Container 2 - Purchases
                  Container(
                    child: ReceiptsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Receipts', VouchersHome()),
                  Container(
                    child: PurchasesDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Purchases', PurchaseOrderReportScreen()),
                  Container(
                    child: PaymentsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Payments', VouchersHome()),
                  // Column(
                  //   children: <Widget>[
                  //     Text(
                  //       'Coming soon...',
                  //       style: TextStyle(
                  //         backgroundColor: bmsWarning,
                  //         color: bmsWhite,
                  //         fontSize: 24.0,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // Container(
                  //   child: ExpenseDashboardWidget(),
                  //   margin: const EdgeInsets.all(15.0),
                  //   // decoration: myBoxDecorationTopBorder()
                  // ),
                  // GoToBar('Check Expenses', DashboardScreen()),
                  // Container(
                  //   child: CashWidget(),
                  //   margin: const EdgeInsets.all(15.0),
                  // ),
                  // GoToBar('Check Bank Reconciliation', DashboardScreen()),
                  Container(
                    child: OutstandingsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Accounts Payables', AccountsPayableScreen()),
                  GoToBar('Accounts Receivables', AccountsReceivableScreen())
                ],
              ),
            ),
          ),
        ));
  }
}
