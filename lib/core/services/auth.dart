import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:bms/core/models/user.dart';
import 'package:provider/provider.dart';

class AuthService {
  static var _authCredential, actualCode;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // convert firebase user into custom User instance
  _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
    // .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      // return _userFromFirebaseUser(user);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      debugPrint('Hello -- $user');
      FirebaseFirestore.instance.collection('metrics').doc(user.uid).set({
        // 'total_sales': 100000,
        // 'total_payments': 0,
        // 'total_purchases': 50000,
        // 'total_receipts': 0,
        // 'out_actual_rec': 100000,
        // 'out_actual_pay': 50000,
        // 'net_profit': '1000 Cr',
        // 'cash_in_hand': '12000 Dr',
        // 'cash_in_bank': '42000 Dr'

        'total_sales': 10070,
        'total_payments': 700,
        'total_purchases': 500,
        'total_receipts': 700,
        'out_actual_rec': 2,
        'out_actual_pay': 3,
        'net_profit': '50000 Cr',
        'cash_in_hand': '100000 Dr',
        'cash_in_bank': '10000 Dr'
      });

      // Company
      FirebaseFirestore.instance.collection('company').doc(user.uid).set({
        'email': user.email,
      });

      // Stock
      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('stockitem')
          .doc('1')
          .set({
        'name': 'Gur',
        'masterid': '1',
        'closingbalance': 100,
        'closingvalue': 25000,
        'baseunits': 'kg',
        'closingrate': 250,
        'standardcost': 225,
        'standardprice': 240,
      });
      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('stockitem')
          .doc('2')
          .set({
        'name': 'Wheat',
        'masterid': '2',
        'closingbalance': 10,
        'closingvalue': 2500,
        'baseunits': 'kg',
        'closingrate': 250,
        'standardcost': 200,
        'standardprice': 225,
      });

      // Ledger
      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('ledger')
          .doc('1')
          .set(
        {
          'name': 'ABC Ltd',
          'masterid': '1',
          'currencyname': 'Rupees',
          'openingbalance': 0,
          'closingbalance': -100000,
          'parentcode': '20',
          'contact': '',
          'address1': 'CP, New Delhi',
          'address2': '',
          'state': 'Delhi',
          'pincode': '110001',
          'email': 'xyz@email.com',
          'phone': '9999999999',
          'guid': '1',
          'gst': 'XXXXXXXXXXXX',
          // 'restat_primary_group_type': 'Sundry Debtors',
        },
      );

      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('ledger')
          .doc('2')
          .set(
        {
          'name': 'Cash',
          'masterid': '2',
          'currencyname': 'Rupees',
          'openingbalance': 1000,
          'closingbalance': 101000,
          'parentcode': '',
          'contact': '',
          'address1': '',
          'address2': '',
          'state': 'Delhi',
          'pincode': '110001',
          'email': '',
          'phone': '',
          'guid': '2',
          'gst': '',
          // 'restat_primary_group_type': '',
        },
      );

      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('ledger')
          .doc('3')
          .set({
        'name': 'BCD Ltd',
        'masterid': '3',
        'currencyname': 'Rupees',
        'openingbalance': 0,
        'closingbalance': 50000,
        'parentcode': '16',
        'contact': '',
        'address1': 'CP, New Delhi',
        'address2': '',
        'state': 'Delhi',
        'pincode': '110001',
        'email': 'abc@email.com',
        'phone': '9898989898',
        'guid': '3',
        'gst': 'ABCD1234PQ56',
        // 'restat_primary_group_type': 'Sundry Creditors',
      });

      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('ledger')
          .doc('4')
          .set({
        'name': 'GST @ 18%',
        'masterid': '4',
        'currencyname': 'Rupees',
        'openingbalance': 0,
        'closingbalance': 396,
        'parentid': '',
        'contact': '',
        'address1': 'CP, New Delhi',
        'address2': '',
        'state': 'Delhi',
        'pincode': '',
        'email': '',
        'phone': '9898989898',
        'guid': '4',
        'gst': '',
      });

      // Voucher
      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('voucher')
          .doc('1')
          .set({
        'vdate': DateTime.now(),
        // 'restat_party_ledger_name': 'ABC Ltd',
        'amount': 2596,
        'masterid': '1',
        'guid': '1',
        'iscancelled': '0',
        'primaryvouchertypename': 'Sales',
        'isinvoice': '1',
        'type': 'Sales',
        'partyledgername': '1',
        'number': '1',
        'inventoryentries': [
          {
            'rate': 220,
            'gstpercent': '18',
            'billedqty': 10,
            'actualqty': 10,
            'amount': 2596,
            'taxamount': 396,
          }
        ],
        'ledgerentries': [
          {
            'amount': '2200',
            'isdeemedpositive': '1',
            'ispartyledger': '1',
            'ledger_guid': '1',
            'ledgername': '1',
            'ledgerrefname': '',
            'parent': '',
            'primarygroup': ''
          },
          {
            'amount': '396',
            'isdeemedpositive': '1',
            'ledger_guid': '4',
            'ispartyledger': '0',
            'ledgername': '1',
            'ledgerrefname': '',
            'parent': '',
            'primarygroup': ''
          }
        ],
      });

      // Ledger Stock

      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('ledger')
          .doc('1')
          .collection('ledger_stock_metrics')
          .doc('1')
          .set({
        'last_amount': '2596',
        'last_discount': '0',
        'last_rate': '220',
        'last_voucher_date': DateTime.now(),
        'mean_amount': '2596',
        'num_vouchers': '1',
        // 'restat_stock_item_name': 'Wheat',
        'stockitemname': '1',
        'total_actualqty': '10',
        'total_amount': '2596',
        'total_billedqty': 10,
        'voucher_type': 'Sales'
      });

      FirebaseFirestore.instance
          .collection('company')
          .doc(user.uid)
          .collection('inventory_entries')
          .doc('1')
          .set({
        'restat_stock_item_name': 'Wheat',
        'restat_party_ledger_name': 'XYZ Ltd',
        'restat_voucher_date': DateTime.now(),
        'restat_voucher_master_id': '1',
        'rate': 220,
        // 'primary_voucher_type_name': 'Sales',
        'gstpercent': '18',
        'billedqty': 10,
        'actualqty': 10,
        'amount': 2596,
        'taxamount': 396,
      });

      // FirebaseFirestore.instance
      //     .collection('company')
      //     .doc(user.uid)
      //     .collection('ledger_entries');

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // // Future verifyPhone(String phone) async {
  // //   print(phone.toString());
  // //   _auth
  // //       .verifyPhoneNumber(
  // //           phoneNumber: phone.toString(),
  // //           timeout: Duration(seconds: 60),
  // //           verificationCompleted: verificationCompleted,
  // //           verificationFailed: verificationFailed,
  // //           codeSent: codeSent,
  // //           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
  // //       .then((value) {
  // //     print('Code sent');
  // //   }).catchError((error) {
  // //     print(error.toString());
  // //   });
  // // }
  // //
  // // void codeSent(String verificationId, [int forceResendingToken]) async {
  // //   actualCode = verificationId;
  // //   print("\nEnter the code sent");
  // // }
  // //
  // // void codeAutoRetrievalTimeout(String verificationId) {
  // //   actualCode = verificationId;
  // //   print("\nAuto retrieval time out");
  // // }
  // //
  // // void verificationFailed(AuthException authException) {
  // //   print('${authException.message}');
  // //   if (authException.message.contains('not authorized'))
  // //     print('App not authroized');
  // //   else if (authException.message.contains('Network'))
  // //     print('Please check your internet connection and try again');
  // //   else
  // //     print('Something has gone wrong, please try later ' +
  // //         authException.message);
  // // }
  //
  // void verificationCompleted(AuthCredential auth) {
  //   print('Auto retrieving verification code');
  //
  //   _auth.signInWithCredential(auth).then((AuthResult result) {
  //     if (result.user != null) {
  //       print('Authentication successful');
  //       // onAuthenticationSuccessful();
  //     } else {
  //       print('Invalid code/invalid authentication');
  //     }
  //   }).catchError((error) {
  //     print('Something has gone wrong, please try later $error');
  //   });
  // }
  //
  // Future signInWithPhone({String smsCode}) async {
  //   _authCredential = PhoneAuthProvider.getCredential(
  //       verificationId: actualCode, smsCode: smsCode);
  //
  //   _auth.signInWithCredential(_authCredential).then((AuthResult result) async {
  //     print('Authentication successful');
  //     // onAuthenticationSuccessful();
  //   }).catchError((error) {
  //     print(
  //         'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
  //   });
  // }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:bms/database.dart';

// abstract class BaseAuth {
//   Future<String> signIn(String email, String password);
//   Future<String> signUp(String email, String password);
//   Future<FirebaseUser> getCurrentUser();
//   Future<void> signOut();
// }

// class Auth implements BaseAuth {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   Future<String> signIn(String email, String password) async {
//     // FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;
//     return user.uid;
//   }
//   Future<String> signUp(String email, String password) async {
//     AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;
//     var userId = user.uid;

//     // create a new metric doc when a user signs up
//     await DatabaseService( uid: userId ).createMetricsRecord();

//     return userId;
//   }
//   Future<FirebaseUser> getCurrentUser() async {
//     FirebaseUser user = await _firebaseAuth.currentUser();
//     return user;
//   }
//   Future<void> signOut() async {
//     return _firebaseAuth.signOut();
//   }
// }
