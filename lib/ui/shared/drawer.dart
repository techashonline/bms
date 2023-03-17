import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/services/auth.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/theme/dimensions.dart';
import 'package:bms/ui/views/accountspayablescreen.dart';
import 'package:bms/ui/views/accountsreceivables.dart';
// import 'package:bms/ui/views/crm.dart';
import 'package:bms/ui/views/home.dart';
import 'package:bms/ui/views/ledgerinput.dart';
import 'package:bms/ui/views/khatascreen.dart';
import 'package:bms/ui/views/ledgerscreen.dart';
import 'package:bms/ui/views/settingsscreen.dart';
// import 'package:bms/ui/views/productionInput.dart';
// import 'package:bms/ui/views/pruchaseorderreport.dart';
// import 'package:bms/ui/views/salesorderreport.dart';
import 'package:bms/ui/views/stockscreen.dart';
import 'package:bms/ui/views/vouchers.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

final AuthService _auth = AuthService();

Drawer bmsDrawer(BuildContext context) {
  final user = Provider.of<User>(context);

  return Drawer(
      child: ListView(
    children: <Widget>[
      DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                Icons.person_outline,
                color: bmsInfoGrey,
                size: 40.0,
              ),
              radius: 25.0,
              backgroundColor: bmsWhite,
            ),
            SizedBox(
              width: 70,
            ),

            FittedBox(
              child: Text(
                user?.email ?? 'No email',
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: bmsWhite,
                      fontSize: 14.0,
                    ),
              ),
            ),

            //  RaisedButton(
            //    color: bmsWhite,
            //    child:
            //    Row(children: <Widget>[
            //   Icon(FontAwesomeIcons.laptop),
            //   SizedBox(width: 20),
            //   Text('Get Tally Connector')

            //    ]),
            // onPressed: () => _launchURL(),)
          ],
        ),
        decoration: BoxDecoration(
          color: bmsMenuBg,
          shape: BoxShape.rectangle,
        ),
      ),
      Padding(
        padding: spacer.all.xxs,
        child: Text('Reports', style: Theme.of(context).textTheme.bodyText1),
      ),
      DrawerItem(
        icon: Icons.dashboard,
        title: 'Home',
        ontap: HomeDashboardScreen(),
        color: bmsPrimaryBackground,
      ),
      DrawerItem(
        icon: FontAwesomeIcons.listAlt,
        title: 'Ledgers / Parties',
        ontap: LedgerScreen(),
        color: bmsPrimaryBackground,
      ),
      // DrawerItem(
      //   icon: Icons.call_received,
      //   title: 'Accounts Receivables',
      //   ontap: AccountsReceivableScreen(),
      //   color: bmsPrimaryBackground,
      // ),
      // DrawerItem(
      //   icon: Icons.call_made,
      //   title: 'Accounts Payables',
      //   ontap: AccountsPayableScreen(),
      //   color: bmsPrimaryBackground,
      // ),
      DrawerItem(
        icon: FontAwesomeIcons.warehouse,
        title: 'Stock',
        ontap: StockScreen(),
        color: bmsPrimaryBackground,
      ),
      DrawerItem(
        icon: FontAwesomeIcons.fileInvoice,
        title: 'Vouchers',
        ontap: VouchersHome(),
        color: bmsPrimaryBackground,
      ),
      DrawerItem(
        icon: Icons.receipt,
        title: 'Make New Invoice',
        ontap: SettingsScreen(),
        // ontap: LedgerInputScreen(),
        color: bmsPrimary,
      ),
      Padding(
        padding: spacer.all.xxs,
        child: Text('', style: Theme.of(context).textTheme.bodyText1),
      ),
      // DrawerItem(
      //   icon: Icons.lock,
      //   title: 'Bahi Khata',
      //   ontap: KhataScreen(),
      //   color: bmsMainText,
      // ),
      DrawerItem(
        icon: Icons.settings,
        title: 'Settings',
        ontap: SettingsScreen(),
        color: bmsMainText,
      ),
      SizedBox(
        height: 20.0,
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
                    .headline1
                    ?.copyWith(fontSize: 16),
              ),
            ],
          ),
          onTap: () async {
            await _auth.signOut().then((_) {
              // Navigator.popUntil(context, );
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new MyApp()),
                  ModalRoute.withName('/'));
            });
          },
        ),
      ),
    ],
  ));
}

class DrawerItem extends StatefulWidget {
  final IconData? icon;
  final String? title;
  final Widget? ontap;
  final Color? color;

  DrawerItem({this.icon, this.title, this.ontap, this.color});

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: bmsSuccess,
      child: Padding(
        padding: spacer.y.xxs,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: spacer.x.xs,
              child: Icon(
                widget.icon,
                color: widget.color,
              ),
            ),
            Text(
              widget.title!,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: widget.color, fontSize: 16),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => widget.ontap!,
        ));
      },
    );
  }
}

_launchURL() async {
  const url = '';
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  throw 'Could not launch $url';
  // }
}
