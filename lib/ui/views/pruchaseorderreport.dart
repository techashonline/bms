import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/services/database.dart';
import 'package:bms/theme/dimensions.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/ui/views/accountspayablescreen.dart';
import 'package:bms/ui/views/ledgerscreen.dart';
import 'package:bms/ui/views/stockscreen.dart';
import 'package:bms/ui/widgets/coloredIcon.dart';
import 'package:bms/ui/widgets/secondarysectionheader.dart';
import 'package:bms/ui/widgets/gotobar.dart';
import 'package:bms/ui/widgets/sectionHeader.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bms/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bms/core/models/ledger.dart';
import 'package:bms/core/services/string_format.dart';

class PurchaseOrderReportScreen extends StatelessWidget {
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
                SectionHeader('Purchases'),
                // Container(

                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Expanded(
                //         child: Container(
                //           padding: spacer.x.xs,
                //           margin: spacer.all.xxs,
                //           color: Color(0xffEDF4FC),
                //           child: Row(
                //             children: <Widget>[
                //               Text('Product'),
                //               Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Container(
                //           padding: spacer.x.xs,
                //            margin: spacer.all.xxs,
                //           color: Color(0xffEDF4FC),
                //           child: Row(
                //             children: <Widget>[
                //               Text('Customer'),
                //               Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
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
                        ColoredIconNumberRow(
                            'total_purchases', 'Total Purchases'),
                        ColoredIconNumberRow(
                            'num_purchase_vouchers', '# Vouchers'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        ColoredIconNumberRow(
                            'total_payments', 'Total Payments'),
                        ColoredIconNumberRow(
                            'num_payments_vouchers', '# Vouchers'),
                      ],
                    )
                  ],
                ),

                SecondarySectionHeader('Inactive Supplier List'),

                InactiveSupplierList(),

                GoToBar('Top Suppliers', LedgerScreen()),
                GoToBar('Top Items Due', StockScreen()),
                GoToBar('Top Accounts Payable', AccountsPayableScreen())
              ],
            ),
          ),
        ));
  }
}

class InactiveSupplierList extends StatefulWidget {
  final LedgerItem? ledgerItem;

  InactiveSupplierList({this.ledgerItem});

  @override
  _InactiveSupplierListState createState() => _InactiveSupplierListState();
}

class _InactiveSupplierListState extends State<InactiveSupplierList> {
  Iterable<LedgerItem>? inactiveSuppliers;

  List<LedgerItem> inactiveSupplierData = <LedgerItem>[];

  @override
  Widget build(BuildContext context) {
    final inactiveSuppliers = Provider.of<List<LedgerItem>>(context)
            .where((element) => element.closingBalance == 0)
            .where(
                (element) => element.primaryGroupType == 'Sundry Creditors') ??
        [];
    inactiveSupplierData.addAll(inactiveSuppliers);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text(
                'Total Inactive Suppliers: ${inactiveSupplierData?.length}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: spacer.all.xxs,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Party Name    ',
                      style: TextStyle(
                          color: bmsPrimary, fontWeight: FontWeight.bold),
                    ),
                    // Text( 'Op Balance  ', style: TextStyle(color: bmsInfoGrey, fontWeight: FontWeight.bold),),
                    Text(
                      'Difference',
                      style: TextStyle(
                          color: bmsBlack, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.phone)
                  ]),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: inactiveSupplierData?.length ?? 0,
                itemBuilder: (context, index) {
                  return LedgerItemTile(
                      ledgerItem: inactiveSupplierData[index]);
                },
              ),
            ),
          ],
        ));
  }
}

class LedgerItemTile extends StatelessWidget {
  final LedgerItem? ledgerItem;

  LedgerItemTile({this.ledgerItem});

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      var url = 'https://api.whatsapp.com/send?phone=${ledgerItem!.phone}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return FittedBox(
      child: Card(
        borderOnForeground: true,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(
                ledgerItem!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14, color: bmsPrimaryBackground),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            // Text(formatIndianCurrency(ledgerItem.openingBalance), style: TextStyle(color: bmsInfoGrey)),
            SizedBox(
              width: 10,
            ),

            Text(formatIndianCurrency(ledgerItem!.totalPayables!)),
            IconButton(
              onPressed: () {
                _launchURL();
              },
              icon: Icon(
                FontAwesomeIcons.whatsapp,
                color: bmsSuccess,
              ),
            )
          ],
        ),
      ),
    );
  }
}
