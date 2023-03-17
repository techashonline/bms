// @dart=2.9
import 'package:bms/core/models/receivables.dart';
import 'package:bms/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bms/core/models/inactivecustomer.dart';
import 'package:bms/core/models/payables.dart';
import 'package:bms/core/models/paymentvoucher.dart';
import 'package:bms/core/models/purchasevoucher.dart';
import 'package:bms/core/models/receiptvoucher.dart';
import 'package:bms/core/models/receivables.dart';
import 'package:bms/core/models/salesvoucher.dart';
import 'package:bms/core/models/stockitem.dart';
import 'package:bms/core/models/vouchers.dart';
import 'package:bms/core/services/auth.dart';
import 'package:bms/core/services/database.dart';
import 'package:bms/core/services/inactivecustomerservice.dart';
import 'package:bms/core/services/payablesservice.dart';
import 'package:bms/core/services/paymentvoucherservice.dart';
import 'package:bms/core/services/purchasevoucherservice.dart';
import 'package:bms/core/services/receiptvoucherservice.dart';
import 'package:bms/core/services/receivablesservice.dart';
import 'package:bms/core/services/stockservice.dart';
import 'package:bms/core/services/vouchers.dart';
import 'package:bms/route_generator.dart';
import 'package:bms/theme/texts.dart';
import 'package:bms/ui/root_page.dart';
import 'package:bms/ui/views/homescreen.dart';
import 'package:bms/ui/views/ledgerscreen.dart';
import 'package:bms/ui/views/ledgerview.dart';
import 'package:bms/ui/views/vouchers.dart';
import 'package:bms/ui/views/voucherview.dart';
import 'core/models/company.dart';
import 'core/models/ledger.dart';
import 'core/services/companyservice.dart';
import 'core/services/ledgerservice.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = "BMS";

    return MultiProvider(providers: [
      StreamProvider<User>.value(
        value: AuthService().user,
        initialData: null,
      ),
    ], child: TopWidget(title: _title));
  }
}

class TopWidget extends StatefulWidget {
  const TopWidget({
    String title,
  })  : _title = title,
        super();

  final String _title;

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  // final FirebaseMessaging _fcm = FirebaseMessaging();

  // StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();

    // String uid = Provider.of<FirebaseUser>(context, listen: false).uid;

    // if (Platform.isIOS) {
    //   iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
    //     print(data);
    //     _saveDeviceToken();
    //   });

    //   _fcm.requestNotificationPermissions(IosNotificationSettings());
    // } else {
    //   _saveDeviceToken();
    //   // }
    //
    //   _fcm.configure(
    //     onMessage: (Map<String, dynamic> message) async {
    //       print("onMessage: $message");
    //       // final snackbar = SnackBar(
    //       //   content: Text(message['notification']['title']),
    //       //   action: SnackBarAction(
    //       //     label: 'Go',
    //       //     onPressed: () => null,
    //       //   ),
    //       // );
    //
    //       // Scaffold.of(context).showSnackBar(snackbar);
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           content: ListTile(
    //             title: Text(message['notification']['title']),
    //             subtitle: Text(message['notification']['body']),
    //           ),
    //           actions: <Widget>[
    //             FlatButton(
    //               color: Colors.amber,
    //               child: Text('Ok'),
    //               onPressed: () => Navigator.of(context).pop(),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //     onLaunch: (Map<String, dynamic> message) async {
    //       print("onLaunch: $message");
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print("onResume: $message");
    //     },
    //   );
    // }
    //
    // /// Get the token, save it to the database for current user
    // _saveDeviceToken() async {
    //   // Get the current user
    //   // String uid = 'jeffd23';
    //   // FirebaseUser user = await _auth.currentUser();
    //
    //   // Get the token for this device
    //   await _fcm.getToken();
    //
    //   // Save it to FirebaseFirestore
    //   // if (fcmToken != null) {
    //   //   var tokens = _db
    //   //       .collection('company')
    //   //       .doc(uid)
    //   //       .collection('tokens')
    //   //       .doc(fcmToken);
    //
    //   //   await tokens.set({
    //   //     'token': fcmToken,
    //   //     'createdAt': FieldValue.serverTimestamp(), // optional
    //   //     'platform': Platform.operatingSystem // optional
    //   //   });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<ReceivablesItem>>.value(
          initialData: null,
          value: ReceivablesItemService(uid: user?.uid).accountsReceivableData,
        ),
        // LEDGER/PARTY DATA
        StreamProvider<List<LedgerItem>>.value(
          value: LedgerItemService(uid: user?.uid).ledgerItemData,
          initialData: [],
        ),
        StreamProvider<List<StockItem>>.value(
          value: StockItemService(uid: user?.uid).stockItemsData,
          initialData: [],
        ),
        StreamProvider<List<PayablesItem>>.value(
          value: PayablesItemService(uid: user?.uid).accountsPayablesData,
          initialData: [],
        ),
        StreamProvider<List<InactiveCustomer>>.value(
          value: InactiveCustomerService(uid: user?.uid).inactiveCustomerData,
          initialData: [],
        ),
        StreamProvider<List<SalesVoucher>>.value(
          value: SalesVoucherService(uid: user?.uid).salesVoucherData,
          initialData: [],
        ),
        StreamProvider<List<PurchaseVoucher>>.value(
          value: PurchaseVoucherService(uid: user?.uid).purchaseVoucherData,
          initialData: [],
        ),
        StreamProvider<List<PaymentVoucher>>.value(
          value: PaymentVoucherService(uid: user?.uid).paymentVoucherData,
          initialData: [],
        ),
        StreamProvider<List<ReceiptVoucher>>.value(
          value: ReceiptVoucherService(uid: user.uid).receiptVoucherData,
          initialData: [],
        ),
        StreamProvider<List<Voucher>>.value(
          value: VoucherService(uid: user?.uid).voucherData,
          initialData: [],
        ),
        StreamProvider<Company>.value(
          value: CompanyService(uid: user?.uid).companyData,
          initialData: null,
        ),
        StreamProvider<DocumentSnapshot>.value(
          value: DatabaseService().companyCollection.doc(user.uid).snapshots(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: widget._title,
        home: RootPage(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(headline1: primaryAppBarTitle),
          ),
          textTheme: TextTheme(
              headline1: secondaryListTitle,
              subtitle1: secondaryCategoryDesc,
              bodyText1: secondaryListDisc,
              bodyText2: secondaryListTitle2),
        ),
      ),
    );
  }
}
