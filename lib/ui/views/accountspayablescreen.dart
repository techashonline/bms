import 'package:flutter/material.dart';
// import 'package:bms/theme/colors.dart';
// import 'package:bms/theme/dimensions.dart';

import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
// import 'package:bms/ui/views/pruchaseorderreport.dart';
// import 'package:bms/ui/widgets/bigmetricnoicon.dart';
// import 'package:bms/ui/widgets/gotobar.dart';
import 'package:bms/ui/widgets/accountspayables/accountspayablelist.dart';
// import 'package:bms/ui/widgets/secondarysectionheader.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class AccountsPayableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
    // final user = Provider.of<FirebaseUser>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _drawerKey,
          appBar: AppBar(
            title: Text("Accounts Payables"),
          ),
          // bottomNavigationBar: bottomNav(),
          body: ListView(
            children: <Widget>[
              SectionHeader('Accounts Payables'),
              // Text('Dummy data, coming soon!'),
              // Padding(
              //   padding: spacer.all.xs,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //      BigMetricNoIcon('30', '<30 days', bmsSuccess),
              //      BigMetricNoIcon('12', '30-45 days', bmsWarning),
              //      BigMetricNoIcon('16', '45-60 days', bmsDanger),
              //     ],
              //   ),
              // ),
              // SecondarySectionHeader('List of parties'),
              APLedgerItemList(),
            ],
          )),
    );
  }
}
