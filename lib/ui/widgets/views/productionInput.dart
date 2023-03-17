import 'package:flutter/material.dart';
import 'package:bms/core/models/production.dart';
import 'package:bms/theme/dimensions.dart';

import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:bms/ui/widgets/productionForm.dart';
import 'package:bms/ui/widgets/productionList.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';

class ProductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showProductionPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: spacer.all.xs,
              child: ProductionForm(),
            );
          });
    }

    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return StreamProvider<List<Production>>.value(
      value: DatabaseService().productionData,
      initialData: [],
      child: Scaffold(
          appBar: headerNav(_drawerKey),
          // bottomNavigationBar: bottomNav(),
          body: Column(
            children: <Widget>[
              SectionHeader('Daily Production Report'),
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Record Data'),
                onPressed: () => _showProductionPanel(),
              ),
              ProductionList(),
            ],
          )),
    );
  }
}
