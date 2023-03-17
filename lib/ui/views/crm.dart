import 'package:flutter/material.dart';
import 'package:bms/theme/theme.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class CRMScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _drawerKey,
        drawer: bmsDrawer(context),
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            SectionHeader('CRM'),
            Padding(
              padding: spacer.all.xxl,
              child: Column(children: <Widget>[
                Text('Coming Soon... '),
                SizedBox(height: 10.0),
                Text('Want it sooner? WhatsApp us!')
              ]),
            ),
          ],
        ));
  }
}
