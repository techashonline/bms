import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bms/core/models/receivables.dart';
import 'package:bms/core/services/string_format.dart';
import 'package:bms/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleItem extends StatelessWidget {
  final ReceivablesItem? ledgerItem;

  SingleItem({this.ledgerItem});

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

    return Card(
      borderOnForeground: true,
      child: FittedBox(
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.8,
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
            Container(
              width: 80,
              child: Text(
                '${formatIndianCurrency(ledgerItem!.closingBalance.toString().substring(1, ledgerItem!.closingBalance!.length))}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 14, color: bmsBlack),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // Container(
            //   padding: spacer.all.xxs,
            //   margin: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: bmsGray
            //   )
            //   ),
            //     Container(
            //   padding: spacer.all.xxs,
            //   margin: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: bmsGray
            //   )
            //   ),
            //     Container(
            //   padding: spacer.all.xxs,
            //   margin: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: bmsGray
            //   )
            //   ),
            //     Container(
            //   padding: spacer.all.xxs,
            //   margin: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: bmsSuccess
            //   )
            //   ),
            //     Container(
            //   padding: spacer.all.xxs,
            //   margin: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: bmsSuccessLight
            //   )
            //   ),
            //     Container(
            //   padding: spacer.all.xxs,
            //   margin: EdgeInsets.all(1),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: bmsGray
            //   )
            //   ),
            // Text(
            //   '${formatIndianCurrency(ledgerItem.totalReceipt)}',
            //   style: TextStyle(color: bmsInfoGrey),
            // ),

            IconButton(
              onPressed: () {
                _launchURL();
              },
              iconSize: 20,
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
