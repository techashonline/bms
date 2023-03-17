// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// // import 'package:esys_flutter_share/esys_flutter_share.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:bms/core/models/company.dart';
// import 'package:bms/core/models/ledger.dart';
// import 'package:bms/core/models/stockitem.dart';
// import 'package:bms/core/models/voucher-item.dart';
// import 'package:bms/core/services/storageservice.dart';
// import 'package:bms/core/services/voucher-item-service.dart';
// import 'package:bms/core/services/vouchers.dart';
// import 'package:bms/templates/invoice_pdf_template.dart';
// import 'package:bms/theme/colors.dart';
// import 'package:bms/theme/texts.dart';
// import 'package:bms/theme/theme.dart';
// import 'package:bms/ui/shared/drawer.dart';
// import 'package:bms/ui/shared/headernav.dart';
// import 'package:bms/ui/widgets/productcard.dart';
//
// class LedgerInputScreen extends StatefulWidget {
//   @override
//   _LedgerInputScreenState createState() => _LedgerInputScreenState();
// }
//
// class _LedgerInputScreenState extends State<LedgerInputScreen> {
//   bool checkboxValue = false;
//   List productList = [];
//
//   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   String _invoiceNumber = Random().nextInt(1000).toString();
//   String _masterId = Random().nextInt(1000).toString();
//   // Customer details
//   LedgerItem? _customerLedger;
//   String _customerName = '';
//   String _customerGst = '';
//   String _customerPhone = '';
//   String _customerMasterId = '';
//   // Product details
//   List<VoucherItem> _inventoryEntries = [];
//   String _productName = '';
//   String _gstType = '';
//   String? _gstPercentage;
//   String? _productPrice;
//   String? _productQuantity;
//   double _totalProductPrice = 0;
//   double _totalTax = 0;
//   double _totalAmount = 0;
//
//   DateTime _invoiceDateRaw = DateTime.now();
//   String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//   String _dueDate = DateFormat('dd-MM-yyyy')
//       .format(DateTime.now().add(new Duration(days: 30)));
//   bool isCashSwitched = true;
//   //      final List<String> discountPerCent = ['5','10', '15', '20'];
//   // TODO due date to be changed as per credit period.
//
//   // String _currentDiscount;
//
//   cashCredit(bool isCashSwitched) {
//     if (isCashSwitched == true) {
//       return Text(
//         'Cash',
//         style: secondaryListDisc.copyWith(color: bmsMenuBg),
//       );
//     } else {
//       return Text('Credit',
//           style: secondaryListDisc.copyWith(color: bmsInfoGrey));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var uid = Provider.of<User>(context).uid;
//     var ledgerList = Provider.of<List<LedgerItem>>(context, listen: false);
//     var stockList = Provider.of<List<StockItem>>(context, listen: false);
//     var company = Provider.of<Company>(context);
//
//     return WillPopScope(
//         onWillPop: () async => false,
//         child: Scaffold(
//             key: _drawerKey,
//             drawer: bmsDrawer(context),
//             appBar: headerNav(_drawerKey),
//             // bottomNavigationBar: bottomNav(),
//             body: Form(
//               key: _formKey,
//               child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//                 Padding(
//                     padding: spacer.x.xxs,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Text('Invoice ',
//                               style: secondaryListDisc.copyWith(
//                                   color: bmsInfoGrey)),
//                           Text('#$_invoiceNumber'),
//                           SizedBox(
//                             width: 20.0,
//                           ),
//                           Text('Date:', style: TextStyle(color: bmsInfoGrey)),
//                           Text(_currentDate),
//                           IconButton(
//                             icon: Icon(Icons.date_range),
//                             color: bmsMenuBg,
//                             onPressed: () {
//                               showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(2001),
//                                 lastDate: DateTime(2022),
//                                 builder: (BuildContext context, Widget child) {
//                                   return Theme(
//                                     data: ThemeData.light().copyWith(
//                                         //OK/Cancel button text color
//                                         primaryColor: const Color(
//                                             0xFF4A5BF6), //Head background
//                                         accentColor: const Color(
//                                             0xFF4A5BF6) //selection color
//                                         //dialogBackgroundColor: Colors.white,//Background color
//                                         ),
//                                     child: child,
//                                   );
//                                 },
//                               ).then((date) {
//                                 _invoiceDateRaw = date;
//                                 _currentDate =
//                                     DateFormat('dd-MM-yyyy').format(date);
//                               });
//                             },
//                           )
//                         ])),
//                 Padding(
//                   padding: spacer.x.xxs,
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         cashCredit(isCashSwitched),
//                         Switch(
//                           value: isCashSwitched,
//                           onChanged: (value) {
//                             setState(() {
//                               isCashSwitched = value;
//                             });
//                           },
//                           activeTrackColor: bmsBgLightPurple,
//                           activeColor: bmsMenuBg,
//                         ),
//                         SizedBox(width: 10),
//                         Text('Due Date:',
//                             style:
//                                 secondaryListDisc.copyWith(color: bmsInfoGrey)),
//                         Text('$_dueDate'),
//                         IconButton(
//                           icon: Icon(Icons.date_range),
//                           color: bmsMenuBg,
//                           onPressed: () {
//                             showDatePicker(
//                               context: context,
//                               initialDate:
//                                   DateTime.now().add(new Duration(days: 30)),
//                               firstDate: DateTime(2001),
//                               lastDate: DateTime(2022),
//                               builder: (BuildContext context, Widget child) {
//                                 return Theme(
//                                   data: ThemeData.light().copyWith(
//                                       //OK/Cancel button text color
//                                       primaryColor: const Color(
//                                           0xFF4A5BF6), //Head background
//                                       accentColor: const Color(
//                                           0xFF4A5BF6) //selection color
//                                       //dialogBackgroundColor: Colors.white,//Background color
//                                       ),
//                                   child: child,
//                                 );
//                               },
//                             ).then((date) {
//                               _dueDate = DateFormat('dd-MM-yyyy').format(date);
//                             });
//                           },
//                         ),
//                       ]),
//                 ),
//                 Padding(
//                   padding: spacer.x.xxs,
//                   child: Container(
//                     // width: MediaQuery.of(context).size.width / 1.2,
//                     child: Padding(
//                       padding: spacer.x.xxs,
//                       child: Center(
//                         child: DropdownButtonFormField(
//                           // value: _customerName,
//                           isExpanded: true,
//                           items: ledgerList.map((l) {
//                             return DropdownMenuItem(
//                               child: Text(l.name!),
//                               value: l,
//                             );
//                           }).toList(),
//                           style: secondaryListDisc,
//                           decoration: InputDecoration(
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                             icon: Icon(
//                               Icons.person,
//                               color: bmsPrimary,
//                               size: 20,
//                             ),
//                             hintText: 'Select customer',
//                             hintStyle: secondaryHint,
//                             labelText: 'Customer name',
//                             labelStyle:
//                                 secondaryListTitle.copyWith(fontSize: 16),
//                           ),
//                           onChanged: (val) {
//                             setState(() {
//                               _customerLedger = val;
//                               _customerMasterId = val!.masterId!;
//                               _customerName = val!.name!;
//                               _customerGst = (val.gst ?? '');
//                               _customerPhone = (val.phone ?? '');
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     // decoration: BoxDecoration(
//                     //     borderRadius: BorderRadius.all(Radius.circular(8)),
//                     //     color: bmsBgLightPurple)
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: spacer.x.xxs,
//                 //   child: Text(
//                 //     _customerName,
//                 //     overflow: TextOverflow.ellipsis,
//                 //     maxLines: 2,
//                 //     style: Theme.of(context).textTheme.headline.copyWith(
//                 //           fontSize: 12.0,
//                 //         ),
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: spacer.x.xxs,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Text(
//                         'GST: $_customerGst',
//                         style: secondaryListTitle2.copyWith(
//                             color: bmsInfoGrey, fontSize: 14),
//                       ),
//                       SizedBox(width: 30),
//                       Icon(Icons.phone, color: bmsMenuBg),
//                       Text(
//                         '$_customerPhone',
//                         style: secondaryListTitle2.copyWith(
//                             color: bmsInfoGrey, fontSize: 14),
//                       )
//                     ],
//                   ),
//                 ),
//
//                 // Container(
//                 //   color: bmsInfoGrey,
//                 //   height: 2,
//                 // ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//                   child: Row(
//                     children: <Widget>[
//                       Flexible(
//                         flex: 4,
//                         child: Container(
//                           child: DropdownButtonFormField(
//                             // value: _productName,
//                             isExpanded: true,
//                             items: stockList.map((p) {
//                               return DropdownMenuItem(
//                                 child: Text(p.name),
//                                 value: p,
//                               );
//                             }).toList(),
//                             style: secondaryListDisc,
//                             decoration: InputDecoration(
//                                 icon: Icon(
//                                   Icons.playlist_add,
//                                   color: bmsPrimary,
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.white),
//                                 ),
//                                 isDense: true,
//                                 hintText: 'Add product',
//                                 hintStyle: secondaryHint,
//                                 labelText: 'Add Product(s)',
//                                 labelStyle:
//                                     secondaryListTitle.copyWith(fontSize: 16)),
//                             onChanged: (val) =>
//                                 setState(() => _productName = val!.name),
//                           ),
//                           // decoration: BoxDecoration(
//                           //     border: Border.all(color: bmsPrimary),
//                           //     borderRadius:
//                           //         BorderRadius.all(Radius.circular(8)),
//                           //     color: bmsBgLightPurple)
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Flexible(
//                         flex: 2,
//                         child: new DropdownButtonFormField(
//                           isExpanded: true,
//                           items: <DropdownMenuItem>[
//                             DropdownMenuItem(
//                               child: Text('IGST',
//                                   style:
//                                       secondaryListDisc.copyWith(fontSize: 12)),
//                               value: 'igst',
//                             ),
//                             DropdownMenuItem(
//                               child: Text('CGST & SGST',
//                                   style:
//                                       secondaryListDisc.copyWith(fontSize: 12)),
//                               value: 'cgst & sgst',
//                             ),
//                           ],
//                           // value: 'igst',
//                           decoration: InputDecoration(
//                               isDense: true,
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               labelText: 'GST Type',
//                               // AT: This should be a dropdown
//                               labelStyle:
//                                   secondaryListDisc.copyWith(fontSize: 14)),
//                           onChanged: (val) => setState(() => _gstType = val),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Flexible(
//                         flex: 1,
//                         child: new TextFormField(
//                           keyboardType: TextInputType.number,
//                           style: secondaryListDisc,
//                           decoration: InputDecoration(
//                               labelText: 'GST %',
//                               // AT: This should be a dropdown
//                               labelStyle:
//                                   secondaryListDisc.copyWith(fontSize: 14)),
//                           onChanged: (val) =>
//                               setState(() => _gstPercentage = val),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: spacer.x.xxs,
//                 //   child: Text(
//                 //     _productName,
//                 //     overflow: TextOverflow.ellipsis,
//                 //     maxLines: 2,
//                 //     style: Theme.of(context).textTheme.headline.copyWith(
//                 //           fontSize: 12.0,
//                 //         ),
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: spacer.x.xs,
//                   child: new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       new Flexible(
//                         child: new TextFormField(
//                           style: secondaryListDisc,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                               icon: Icon(Icons.attach_money, color: bmsPrimary),
//                               contentPadding: EdgeInsets.all(8),
//                               labelText: 'Price',
//                               labelStyle: secondaryListDisc),
//                           onChanged: (val) =>
//                               setState(() => _productPrice = val),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                       new Flexible(
//                         child: new TextFormField(
//                           style: secondaryListDisc,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                               icon:
//                                   Icon(Icons.shopping_cart, color: bmsPrimary),
//                               contentPadding: EdgeInsets.all(8),
//                               labelText: 'Qty',
//                               labelStyle: secondaryListDisc),
//                           onChanged: (val) =>
//                               setState(() => _productQuantity = val),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20.0,
//                       ),
//                       new Flexible(
//                         child: ElevatedButton(
//                           // Add to productList
//                           onPressed: () {
//                             // 'Product 1', 'HSN Code: ABCDEF',
//                             //       '100 Qty @ 10/item',
//                             //       'GST @ 5%: 50',
//                             //       'Amount: 1000',
//                             //       'Discount: 10'
//                             double amount = double.parse(_productQuantity!) *
//                                 double.parse(_productPrice!);
//                             double gstAmount;
//                             List tempList;
//                             if (_gstType == 'igst') {
//                               gstAmount =
//                                   ((double.parse(_gstPercentage!)) / 100) *
//                                       amount;
//                               tempList = [
//                                 _productName,
//                                 'HSN Code: ',
//                                 '$_productQuantity Qty @ $_productPrice/item',
//                                 'IGST @ $_gstPercentage% : $gstAmount',
//                                 'Amount: $amount',
//                                 'Discount: ',
//                               ];
//                             } else {
//                               gstAmount =
//                                   (((double.parse(_gstPercentage!)) * 2.0) /
//                                           100) *
//                                       amount;
//                               tempList = [
//                                 _productName,
//                                 'HSN Code: ',
//                                 '$_productQuantity Qty @ $_productPrice/item',
//                                 'CGST & SGST @ ${double.parse(_gstPercentage!) / 2} % : $gstAmount',
//                                 'Amount: $amount',
//                                 'Discount: ',
//                               ];
//                             }
//                             setState(() {
//                               _inventoryEntries.add(VoucherItem(
//                                 actualQty: _productQuantity,
//                                 amount: amount,
//                                 billedQty: double.parse(_productQuantity!),
//                                 discount: '',
//                                 gstPercent: _gstPercentage,
//                                 partyLedgerName: _customerName,
//                                 primaryVoucherType: 'Sales',
//                                 rate: _productPrice,
//                                 stockItemName: _productName,
//                                 taxAmount: gstAmount.toString(),
//                                 taxType: _gstType,
//                                 vDate: _invoiceDateRaw,
//                                 vMasterId: _masterId,
//                               ));
//
//                               _totalProductPrice += amount;
//                               _totalTax += gstAmount;
//                               productList.add(tempList);
//                               _productName = '';
//                               _productPrice = '';
//                               _productQuantity = '';
//                               _gstPercentage = '';
//                               _gstType = '';
//                               _totalAmount = _totalProductPrice + _totalTax;
//                             });
//                           },
//                           child: Icon(
//                             Icons.add,
//                             color: bmsWhite,
//                           ),
//                           // color: bmsPrimaryDarkButtonShadow,
//                           // textColor: Colors.white,
//                           // elevation: 5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: productList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ProductCard(
//                           productList[index][0],
//                           productList[index][1],
//                           productList[index][2],
//                           productList[index][3],
//                           productList[index][4],
//                           productList[index][5]);
//                     },
//                   ),
//                 ),
//                 // DropdownButtonFormField(
//                 //   // value: "16",
//                 //   items: <DropdownMenuItem>[
//                 //     DropdownMenuItem(value: "1", child: Text("1"),),
//                 //   ],
//                 // ['16', '2'].map((trantype) {
//                 //   return DropdownMenuItem(
//                 //     value: "22",
//                 //     child: Text('16', style: secondaryListDisc),
//                 //   );
//                 // }).toList(),
//                 // decoration: new InputDecoration(
//                 //     hintStyle: secondaryListDisc,
//                 //     hintText: 'Discount %',
//                 //     icon: new Icon(
//                 //       Icons.save,
//                 //       color: bmsBlack,
//                 //     )),
//                 //   onChanged: (val) => setState(() => _currentDate = val),
//                 // ),
//
//                 Padding(
//                   padding: spacer.x.xxs,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               // Checkbox(
//                               //   value: checkboxValue,
//                               //   onChanged: (bool value) {
//                               //     setState(() {
//                               //       print(value);
//                               //       checkboxValue = value;
//                               //     });
//                               //   },
//                               //   activeColor: bmsPrimary,
//                               // ),
//                               // Text(
//                               //   'Include payment link',
//                               //   style: secondaryListDisc,
//                               // )
//                             ],
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: spacer.all.xxs,
//                         child: Column(
//                           children: <Widget>[
//                             Text('Total: $_totalAmount',
//                                 style:
//                                     secondaryListTitle.copyWith(fontSize: 18)),
//                             Text(
//                               'Tax: $_totalTax',
//                               style: secondaryListTitle2,
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ]),
//             ),
//             bottomNavigationBar: Row(
//               children: <Widget>[
//                 // PREVIEW Invoice
//                 Flexible(
//                   child: ButtonTheme(
//                     minWidth: MediaQuery.of(context).size.width / 2,
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         String logoPath;
//                         if (company.hasLogo == '1') {
//                           await StorageService().downloadFile(uid + '_logo');
//                           logoPath = Directory.systemTemp.path.toString() +
//                               '/' +
//                               uid +
//                               '_logo';
//                         } else {
//                           logoPath = null;
//                         }
//
//                         await viewPdf(
//                           company: company,
//                           context: context,
//                           invoiceDate: _currentDate,
//                           ledger: _customerLedger,
//                           inventoryEntries: _inventoryEntries,
//                           totalAmount: (_totalProductPrice + _totalTax),
//                           invoiceNumber: _invoiceNumber,
//                           preview: true,
//                           logoPath: logoPath,
//                         );
//                       },
//                       child: Text('Preview',
//                           style: TextStyle(
//                               fontSize: 20, fontFamily: 'Proxima-Nova')),
//                       color: bmsInfoGrey,
//                       textColor: Colors.white,
//                       elevation: 5,
//                     ),
//                   ),
//                 ),
//                 // SAVE and SEND Invoice
//                 Flexible(
//                   child: ButtonTheme(
//                     minWidth: MediaQuery.of(context).size.width / 2,
//                     child: RaisedButton(
//                       onPressed: () async {
//                         await VoucherService(uid: uid).saveVoucherRecord(
//                           amount: (_totalProductPrice + _totalTax),
//                           isInvoice: '1',
//                           partyname: _customerName,
//                           partyMasterId: _customerMasterId,
//                           primaryVoucherType: 'Sales',
//                           type: 'Sales',
//                           date: _invoiceDateRaw,
//                           number: _invoiceNumber,
//                           masterId: _masterId,
//                         );
//
//                         for (var i = 0; i < _inventoryEntries.length; i++) {
//                           await VoucherItemService(uid: uid)
//                               .saveVoucherItemRecord(
//                             actualqty: _inventoryEntries[i].actualQty,
//                             amount: _inventoryEntries[i].amount,
//                             billedQty: _inventoryEntries[i].billedQty,
//                             gstPercent: _inventoryEntries[i].gstPercent,
//                             partyLedgerName:
//                                 _inventoryEntries[i].partyLedgerName,
//                             primaryVoucherType:
//                                 _inventoryEntries[i].primaryVoucherType,
//                             rate: _inventoryEntries[i].rate,
//                             stockItemName: _inventoryEntries[i].stockItemName,
//                             taxAmount: _inventoryEntries[i].taxAmount,
//                             vdate: _inventoryEntries[i].vDate,
//                             vMasterId: _inventoryEntries[i].vMasterId,
//                           );
//                         }
//
//                         String? logoPath;
//                         if (company.hasLogo == '1') {
//                           await StorageService().downloadFile(uid + '_logo');
//                           logoPath = Directory.systemTemp.path.toString() +
//                               '/' +
//                               uid +
//                               '_logo';
//                         } else {
//                           logoPath = null;
//                         }
//
//                         await viewPdf(
//                           company: company,
//                           context: context,
//                           invoiceDate: _currentDate,
//                           ledger: _customerLedger,
//                           inventoryEntries: _inventoryEntries,
//                           totalAmount: (_totalProductPrice + _totalTax),
//                           invoiceNumber: _invoiceNumber,
//                           preview: false,
//                           logoPath: logoPath,
//                         );
//                       },
//                       child: Text('Send',
//                           style: TextStyle(
//                               fontSize: 20, fontFamily: 'Proxima-Nova`')),
//                       color: bmsPrimary,
//                       textColor: Colors.white,
//                       elevation: 5,
//                     ),
//                   ),
//                 ),
//               ],
//             )));
//   }
// }
//
// viewPdf(
//     {context,
//     inventoryEntries,
//     company,
//     ledger,
//     invoiceDate,
//     totalAmount,
//     invoiceNumber,
//     preview,
//     logoPath}) async {
//   // List<VoucherItem> inventoryEntries =
//   //     Provider.of<List<VoucherItem>>(context, listen: false);
//
//   final itemList = _createInvoiceItemList(inventoryEntries, totalAmount);
//
//   final pdf = createInvoicePdf(
//     invoiceNumber: invoiceNumber,
//     invoiceDate: invoiceDate,
//     companyName: company.formalName,
//     companyAddress: company.address,
//     companyPincode: company.pincode,
//     partyName: ledger.name ?? '',
//     partyAddress: ledger.address ?? '',
//     partyPincode: ledger.pincode,
//     partyState: ledger.state,
//     partyGST: ledger.gst ?? '',
//     itemList: itemList,
//     logoPath: logoPath,
//   );
//
//   final String dir = (await getExternalStorageDirectory()).path;
//   final path = "$dir/invoice_$invoiceNumber.pdf";
//   print(path);
//   final file = File(path);
//   await file.writeAsBytes(pdf.save());
//
//   if (preview) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => PdfViewerPage(path: path),
//       ),
//     );
//   } else {
//     try {
//       final Uint8List bytes1 = await file.readAsBytes();
//       //  rootBundle.load('assets/image1.png');
//
//       await Share.files(
//           'esys images',
//           {
//             'invoice_$invoiceNumber.pdf': bytes1,
//           },
//           '*/*',
//           text:
//               'Please find $invoiceNumber worth $totalAmount from $company. It was great doing business with you! - shared via TallyAssist');
//     } catch (e) {
//       print('error: $e');
//     }
//   }
//
//   // return PdfViewerPage(path: path);
// }
//
// class PdfViewerPage extends StatelessWidget {
//   final String path;
//   const PdfViewerPage({Key key, this.path}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return PDFViewerScaffold(
//       path: path,
//     );
//   }
// }
//
// _createInvoiceItemList(inventoryEntries, amount) {
//   List<List<String>> itemList = [
//     [
//       'SI No.',
//       'Description of Goods',
//       'HSN/SAC',
//       'Quantity',
//       'Rate',
//       // 'per',
//       'Disc',
//       'Amount'
//     ]
//   ];
//
//   // We add relevant data to itemList
//   for (var i = 0; i < inventoryEntries.length; i++) {
//     String serialNo = (i + 1).toString();
//     String itemDescription = inventoryEntries[i]?.stockItemName ?? "";
//     String hsnSac = "";
//     String quantity = inventoryEntries[i]?.actualQty.toString() ?? "";
//     String rate = inventoryEntries[i]?.rate.toString() ?? "";
//     // String unit = "";
//     String discount = inventoryEntries[i]?.discount.toString() ?? "";
//     String amount = inventoryEntries[i]?.amount.toString() ?? "";
//     String taxAmount = inventoryEntries[i]?.taxAmount?.toString() ?? "";
//     String taxType = inventoryEntries[i]?.taxType?.toString() ?? "";
//
//     itemList.add([
//       serialNo,
//       itemDescription,
//       hsnSac,
//       quantity,
//       rate,
//       // unit,
//       discount,
//       amount
//     ]);
//     if (taxType == 'igst') {
//       itemList.add([
//         "",
//         "IGST",
//         "",
//         "",
//         "",
//         "",
//         taxAmount,
//       ]);
//     } else {
//       itemList.add([
//         "",
//         "CGST",
//         "",
//         "",
//         "",
//         "",
//         (double.parse(taxAmount) / 2).toString(),
//       ]);
//       itemList.add([
//         "",
//         "SGST",
//         "",
//         "",
//         "",
//         "",
//         (double.parse(taxAmount) / 2).toString(),
//       ]);
//     }
//   }
//
//   itemList.add(["", "Total", "", "", "", "", amount.toString()]);
//
//   return itemList;
// }
