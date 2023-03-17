import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bms/core/models/production.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/theme/dimensions.dart';

import 'package:bms/ui/shared/bottomsheetcustom.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:bms/ui/widgets/productionForm.dart';
import 'package:bms/ui/widgets/productionList.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class ProductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // void _showProductionPanel() {
    //   showModalBottomSheetCustom(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           padding: spacer.all.xs,
    //           child: ProductionForm(),
    //         );
    //       });
    // }

    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
    final user = Provider.of<User>(context);

    return StreamProvider<List<Production>>.value(
      //IDFixTODO - pass user to database service
      value: DatabaseService(uid: user.uid).productionData,
      initialData: [],
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _drawerKey,
          drawer: bmsDrawer(context),
          appBar: headerNav(_drawerKey),
          // bottomNavigationBar: bottomNav(),
          body: Column(
            children: <Widget>[
              SectionHeader('Daily Production Report'),
              ProductionList(),
            ],
          ),
          floatingActionButton: Padding(
            padding: spacer.all.xs,
            child: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: bmsPrimaryBackground,
                onPressed: () => null
                // _showProductionPanel(),
                ),
          ),
        ),
      ),
    );
  }
}
