// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:bms/core/models/ledger.dart';
// import 'package:bms/core/services/ledgerservice.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/ui/widgets/partyscreen/ledgeritemlist.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class LedgerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          key: _drawerKey,
          drawer: bmsDrawer(context),
          appBar: headerNav(_drawerKey),
          body: ListView(
            children: <Widget>[SectionHeader('Ledgers'), LedgerItemList()],
          )),
    );
  }
}
