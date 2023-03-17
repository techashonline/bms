// Pending issue - dropdown widget not displaying value

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/models/company.dart';
import 'package:bms/core/services/auth.dart';
// import 'package:bms/core/models/vouchers.dart';
import 'package:bms/core/services/database.dart';
import 'package:bms/main.dart';
// import 'package:bms/core/services/timeperiod_filter_service.dart';
import 'package:bms/theme/theme.dart';
// import 'package:bms/theme/colors.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
import 'package:bms/ui/views/accountspayablescreen.dart';
import 'package:bms/ui/views/accountsreceivables.dart';
// import 'package:bms/ui/views/customerinput.dart';
// import 'package:bms/ui/views/productinput.dart';
import 'package:bms/ui/views/ledgerinput.dart';
import 'package:bms/ui/views/productinput.dart';
import 'package:bms/ui/views/customerinput.dart';
import 'package:bms/ui/views/ledgerscreen.dart';
import 'package:bms/ui/views/settingsscreen.dart';
import 'package:bms/ui/views/stockscreen.dart';
import 'package:bms/ui/views/vouchers.dart';
import 'package:bms/core/services/string_format.dart';
import 'package:bms/ui/widgets/myboxdecoration.dart';

var formatter = new DateFormat('dd-MM-yyyy');
final AuthService _auth = AuthService();
_formatDate(DateTime date) {
  if (date != null) {
    return formatter.format(date);
  } else {
    return 'NA';
  }
}

class HomeDashboardScreen extends StatefulWidget {
  HomeDashboardScreen({Key? key, this.userId}) : super(key: key);

  final String? userId;

  @override
  _HomeDashboardScreenState createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  String timePeriod = 'Everything';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot?>.value(
            value: DatabaseService().metricCollection.doc(user.uid).snapshots(),
            initialData: null,
          ),
        ],
        child: WillPopScope(
            onWillPop: () => Future.value(false),
            child: Scaffold(
              appBar: AppBar(
                title: Text("Budget Management System"),
              ),
              body: SafeArea(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Text(
                        'Dashboard',
                        style: secondaryListTitle,
                      ),
                    ),
                    Container(
                        child: DashboardCard(
                          timePeriod: timePeriod,
                        ),
                        margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        decoration: myBoxDecorationTopBorder()),
                    Padding(
                      padding: spacer.all.xs,
                      child: Text(
                        'View',
                        style: secondaryListTitle,
                      ),
                    ),
                    Padding(
                      padding: spacer.x.xs,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ActionButton(
                                    Icon(FontAwesomeIcons.listAlt),
                                    LedgerScreen(),
                                    'Parties',
                                    ''),
                              ),
                              Expanded(
                                child: ActionButton(
                                    Icon(FontAwesomeIcons.fileInvoice),
                                    VouchersHome(),
                                    'Vouchers',
                                    ''),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ActionButton(
                                    Icon(FontAwesomeIcons.warehouse),
                                    StockScreen(),
                                    'Stock',
                                    ''),
                              ),
                              Expanded(
                                child: ActionButton(Icon(Icons.settings),
                                    SettingsScreen(), 'Set Info', ''),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: spacer.all.xs,
                      child: Text(
                        'Create',
                        style: secondaryListTitle,
                      ),
                    ),
                    Padding(
                      padding: spacer.x.xs,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ActionButton(
                                    Icon(FontAwesomeIcons.fileInvoice),
                                    ProductInputScreen(),
                                    // LedgerInputScreen(),
                                    'Invoice',
                                    ''),
                              ),
                              Expanded(
                                child: ActionButton(
                                    Icon(FontAwesomeIcons.fileAlt),
                                    ProductInputScreen(),
                                    // LedgerInputScreen(),
                                    'Estimate',
                                    ''),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ActionButton(Icon(Icons.person_outline),
                                    CustomerInputScreen(), 'Party', ''),
                              ),
                              Expanded(
                                child: ActionButton(
                                    Icon(Icons.add_shopping_cart),
                                    ProductInputScreen(),
                                    'Product',
                                    ''),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: spacer.all.xs,
                      child: Text(
                        'Account',
                        style: secondaryListTitle,
                      ),
                    ),
                    Padding(
                      padding: spacer.y.xxs,
                      child: InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: spacer.x.xs,
                              child: Icon(
                                Icons.lock_open,
                                color: bmsPrimaryBackground,
                              ),
                            ),
                            Text(
                              'Sign Out',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                              title: new Text('Are you sure want to Signout?'),
                              actions: <Widget>[
                                new TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: new Text('No'),
                                ),
                                new TextButton(
                                  onPressed: () async =>
                                      await _auth.signOut().then((_) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        new MaterialPageRoute(
                                            builder: (context) => new MyApp()),
                                        ModalRoute.withName('/'));
                                  }),
                                  child: new Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}

class StatusBar extends StatefulWidget {
  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    final companyData = Provider.of<Company>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
      child: Row(
        children: <Widget>[
          Text(
            'Synced: ',
            style: TextStyle(fontSize: 12, color: bmsInfoGrey),
          ),
          Text(
            _formatDate(companyData.lastSyncedAt!),
            style: TextStyle(fontSize: 12, color: bmsMenuBg),
          ),
          Expanded(child: SizedBox(width: 20)),
          Text(
            'Last Entry: ',
            style: TextStyle(fontSize: 12, color: bmsInfoGrey),
          ),
          Text(
            _formatDate(companyData.lastEntryDate!),
            style: TextStyle(fontSize: 12, color: bmsMenuBg),
          )
        ],
      ),
      color: bmsBgLightPurple,
      width: MediaQuery.of(context).size.width,
      height: 30,
    );
  }
}

class DashboardCard extends StatefulWidget {
  final String? timePeriod;
  DashboardCard({this.timePeriod});

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument;
    if (widget.timePeriod == 'Everything') {
      userDocument = snapshot.data;
    } else {
      userDocument = snapshot[widget.timePeriod!];
    }

    if (userDocument != null) {
      return FittedBox(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: 70,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VouchersHome(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            formatIndianCurrency(
                                    userDocument['total_sales'].toString()) ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: bmsMainText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Sales',
                            style:
                                secondaryListDisc.copyWith(color: bmsPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  height: 70,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VouchersHome(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            formatIndianCurrency(
                                    userDocument['total_sales'].toString()) ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: bmsMainText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Sales',
                            style:
                                secondaryListDisc.copyWith(color: bmsPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Row(
            children: <Widget>[
              Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 70,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => AccountsReceivableScreen(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              formatIndianCurrency(
                                      userDocument['out_actual_rec']
                                          .toString()) ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: bmsMainText,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'Receivables लेन ',
                              style:
                                  secondaryListDisc.copyWith(color: bmsPrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              Card(
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 70,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => AccountsPayableScreen(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                formatIndianCurrency(
                                        userDocument['out_actual_pay']
                                            .toString()) ??
                                    '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: bmsMainText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'Payables देन',
                                style: secondaryListDisc.copyWith(
                                    color: bmsPrimary),
                              ),
                            ],
                          ),
                        )),
                  ))
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Card(
              elevation: 5,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                height: 100,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VouchersHome(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            // formatIndianCurrency(
                            userDocument['net_profit'].toString() ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: bmsMainText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Net Profit',
                            style:
                                secondaryListDisc.copyWith(color: bmsPrimary),
                          ),
                        ],
                      ),
                    )),
              ))
        ],
      ));
    } else {
      return Container(
        child: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}

class ActionButton extends StatelessWidget {
  final Icon icon;
  final Widget widget;
  final String title;
  final String hindiTitle;

  ActionButton(this.icon, this.widget, this.title, this.hindiTitle);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          width: MediaQuery.of(context).size.width / 4.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: icon,
                    iconSize: 30,
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.grey[800],
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => widget,
                      ));
                    }),
                Text(
                  title,
                  style: secondaryListDisc.copyWith(
                      fontSize: 14, color: bmsPrimary),
                ),
                Text(
                  hindiTitle,
                  style: secondaryListDisc.copyWith(
                      fontSize: 14, color: bmsPrimary),
                )
              ]),
        ));
  }
}
