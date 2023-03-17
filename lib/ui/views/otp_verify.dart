// import 'package:flutter/material.dart';
// import 'package:bms/core/services/auth.dart';
// import 'package:bms/theme/colors.dart';
//
// class PhoneAuthVerify extends StatefulWidget {
//   @override
//   _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
// }
//
// class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String error = '';
//   bool loading = false;
//
//   // text field state
//   String otp = '';
//
//   @override
//   Widget build(BuildContext context) {
//     // return loading ? Loading() : Scaffold(
//     return Scaffold(
//       backgroundColor: bmsWhite,
//       appBar: AppBar(
//         backgroundColor: bmsPrimary,
//         elevation: 0.0,
//         title: Text('Get OTP',
//             style: Theme.of(context)
//                 .textTheme
//                 .headline1!
//                 .copyWith(color: bmsWhite)),
//         // actions: <Widget>[
//         //   FlatButton.icon(
//         //     icon: Icon(
//         //       Icons.person,
//         //       color: bmsWhite,
//         //     ),
//         //     label: Text(
//         //       'Register',
//         //       style: Theme.of(context)
//         //           .textTheme
//         //           .body1
//         //           .copyWith(color: bmsWhite),
//         //     ),
//         //     onPressed: () => widget.toggleView(),
//         //   ),
//         // ],
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 20.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                     icon: Icon(Icons.phone, color: bmsPrimaryBackground),
//                     hintText: 'Verify OTP',
//                     labelText: 'OTP'),
//                 validator: (val) => val!.isEmpty ? 'Verify OTP' : null,
//                 onChanged: (val) {
//                   setState(() => otp = val);
//                 },
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                   child: Text(
//                     'Verify OTP',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       setState(() => loading = true);
//                       await _auth.signInWithPhone(smsCode: otp);
//                     }
//                   }),
//               SizedBox(height: 12.0),
//               Text(
//                 error,
//                 style: TextStyle(color: Colors.red, fontSize: 14.0),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
