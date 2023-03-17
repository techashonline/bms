import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/services/ledgerservice.dart';
import 'package:bms/theme/theme.dart';
import 'package:bms/ui/shared/drawer.dart';
import 'package:bms/ui/shared/headernav.dart';
// import 'package:contact_picker/contact_picker.dart';
// import 'package:native_contact_picker/native_contact_picker.dart';

class CustomerInputScreen extends StatefulWidget {
  @override
  _CustomerInputScreenState createState() => _CustomerInputScreenState();
}

class _CustomerInputScreenState extends State<CustomerInputScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  // final NativeContactPicker _contactPicker = new NativeContactPicker();
  // Contact _contact;
  String? _partyType;
  String? _customerName;
  String? _customerPhone;
  String? _customerGst;
  String? _masterId = Random().nextInt(100000).toString();

  Color? _color;

  Color changePartyButtonCreditor() {
    print(_color);
    print(_partyType);

    if (_partyType == 'Creditor') {
      return _color = bmsSuccessLight;
    } else {
      return _color = bmsBgLightPurple;
    }
  }

  Color changePartyButtonDebtor() {
    print(_color);
    print(_partyType);

    if (_partyType == 'Debtor') {
      return _color = bmsSuccessLight;
    } else {
      return _color = bmsBgLightPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    String? uid = Provider.of<User>(context).uid;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _drawerKey,
          drawer: bmsDrawer(context),
          appBar: headerNav(_drawerKey),
          // bottomNavigationBar: bottomNav(),
          body: Padding(
            padding: spacer.all.xs,
            child: ListView(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Create new customer',
                    style: secondaryListTitle,
                  ),
                  TextFormField(
                    style: secondaryListDisc,
                    decoration: InputDecoration(
                        labelText: 'Customer Name',
                        labelStyle:
                            secondaryListTitle2.copyWith(color: bmsInfoGrey)),
                    onChanged: (value) {
                      setState(() {
                        _customerName = value;
                      });
                    },
                  ),
                  TextFormField(
                      style: secondaryListDisc,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle:
                              secondaryListTitle2.copyWith(color: bmsInfoGrey)),
                      onChanged: (value) {
                        setState(() {
                          _customerPhone = value;
                        });
                      })
                ],
              ),
              // Padding(
              //   padding: spacer.top.sm,
              //   child: Row(
              //     children: <Widget>[
              //       Text(
              //         'OR, select from address book: ',
              //         style: secondaryListTitle,
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //             shape: BoxShape.rectangle,
              //             color: bmsBgLightPurple,
              //             borderRadius: BorderRadius.circular(10)),
              //         child: IconButton(
              //           color: bmsPrimary,
              //           icon: Icon(Icons.person_add),
              //           focusColor: bmsPrimaryDarkButtonShadow,
              //           onPressed: () async {
              //             Contact contact =
              //                 await _contactPicker.selectContact();
              //             setState(() {
              //               _contact = contact;
              //             });
              //           },
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: spacer.bottom.sm,
              //   child: Text(
              //     _contact == null
              //         ? 'No contact selected.'
              //         : _contact.toString(),
              //     style: secondaryListDisc.copyWith(fontSize: 14),
              //   ),
              // )

              Divider(
                height: 20,
              ),
              Text(
                'Party type',
                style: secondaryListTitle,
              ),

              Padding(
                padding: spacer.y.xxs,
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                        child: Text('Customer/Debtor'),
                        // color: changePartyButtonDebtor(),
                        // splashColor: bmsSuccessLight,
                        onPressed: () => {
                              setState(() {
                                _partyType = 'Debtor';
                              })
                            }),
                    SizedBox(width: 10),
                    ElevatedButton(
                        child: Text('Supplier/Creditor'),
                        // color: changePartyButtonCreditor(),
                        // highlightColor: bmsSuccessLight,
                        onPressed: () => {
                              setState(() {
                                _partyType = 'Creditor';
                              })
                            })
                  ],
                ),
              ),
              Padding(
                padding: spacer.top.sm,
                child: Text(
                  'GSTIN (Optional)',
                  style: secondaryListTitle,
                ),
              ),
              TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                      labelText: 'Input 12 digit GST ',
                      // TO DO put validation for 12 digits.
                      labelStyle:
                          secondaryListTitle2.copyWith(color: bmsInfoGrey)),
                  onChanged: (value) {
                    setState(() {
                      _customerGst = value;
                    });
                  }),
              Container(
                padding: spacer.top.sm,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                    child: Text('+ Save Party',
                        style: secondaryListDisc.copyWith(color: bmsWhite)),
                    // color: bmsPrimaryDarkButtonShadow,
                    onPressed: () async {
                      await LedgerItemService(uid: uid).saveLedger(
                        gst: _customerGst,
                        name: _customerName,
                        phone: _customerPhone,
                        partyType: _partyType,
                        masterId: _masterId,
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text(
                                'Party info uploaded successfully',
                                style: secondaryListTitle,
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      //statement(s)
                                    },
                                    child: Text(
                                      'Done',
                                      style: secondaryListDisc,
                                    )),
                              ]);
                        },
                      );
                    }),
              )
            ]),
          ),
        ));
  }
}
