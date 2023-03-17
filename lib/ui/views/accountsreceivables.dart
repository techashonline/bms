// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/theme/dimensions.dart';
// import 'package:provider/provider.dart';
// import 'package:bms/core/models/ledger.dart';
// import 'package:bms/core/services/ledgerservice.dart';
// import 'package:bms/theme/colors.dart';
// import 'package:bms/theme/dimensions.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
// import 'package:bms/ui/views/salesorderreport.dart';
// import 'package:bms/ui/widgets/bigmetricnoicon.dart';
// import 'package:bms/ui/widgets/gotobar.dart';
import 'package:bms/ui/views/accountsreceivablelist.dart';
import 'package:bms/ui/widgets/bigmetricnoicon.dart';
import 'package:bms/ui/widgets/secondarysectionheader.dart';
// import 'package:bms/ui/widgets/secondarysectionheader.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class AccountsReceivableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
    // final user = Provider.of<FirebaseUser>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _drawerKey,
          drawer: bmsDrawer(context),
          appBar: AppBar(),
          // bottomNavigationBar: bottomNav(),
          body: ListView(
            children: <Widget>[
              SectionHeader('Accounts Receivables'),
              Text('Dummy data, coming soon!'),
              Padding(
                padding: spacer.all.xs,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    BigMetricNoIcon('30', '<30 days', bmsSuccess),
                    BigMetricNoIcon('12', '30-45 days', bmsWarning),
                    BigMetricNoIcon('16', '45-60 days', bmsDanger),
                  ],
                ),
              ),
              SecondarySectionHeader('List of parties'),

              ARLedgerItemList(),
              // Padding(
              //   padding: spacer.y.xs,
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         Column(
              //           children: <Widget>[
              //           Icon(Icons.mail, color: bmsPrimary,),
              //           Text('Email All', style: Theme.of(context).textTheme.body1,)
              //           ]
              //         ),
              //         Column(
              //           children: <Widget>[
              //           Icon(Icons.timer, color: bmsPrimary,),
              //           Text('Remind All', style: Theme.of(context).textTheme.body1,)
              //           ]
              //         ),
              //         Column(
              //           children: <Widget>[
              //           Icon(Icons.add_alert, color: bmsPrimary,),
              //           Text('Alert Sales', style: Theme.of(context).textTheme.body1,)
              //           ]
              //         )
              //       ]
              //   ),
              // ),
              // GoToBar('Sales Order Report', SalesOrderReportScreen())
            ],
          )),
    );
  }
}
