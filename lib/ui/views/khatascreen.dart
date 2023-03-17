// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:bms/theme/colors.dart';
// import 'package:bms/theme/dimensions.dart';
//
// import 'package:bms/ui/shared/bottomsheetcustom.dart';
// import 'package:bms/ui/shared/drawer.dart';
// import 'package:bms/ui/shared/headernav.dart';
// import 'package:bms/core/services/database.dart';
// import 'package:provider/provider.dart';
// import 'package:bms/ui/widgets/khataScreen/khataform.dart';
// import 'package:bms/ui/widgets/sectionHeader.dart';
// import 'package:bms/core/models/khata.dart';
// import 'package:bms/ui/widgets/khataScreen/khatalist.dart';
//
// class KhataScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User>(context);
//     // print(user.uid);
//
//     // void _showKhataPanel() {
//     //   showModalBottomSheetCustom(
//     //       context: context,
//     //       builder: (context) {
//     //         return Container(
//     //           padding: spacer.all.xs,
//     //           child: KhataForm(),
//     //         );
//     //       });
//     // }
//
//     final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
//
//     return StreamProvider<List<Khata>>.value(
//       // IDFixTODO - pass current user to database service
//       value: DatabaseService(uid: user.uid).khataData,
//       initialData: [],
//       child: WillPopScope(
//         onWillPop: () async => false,
//         child: Scaffold(
//           key: _drawerKey,
//           drawer: bmsDrawer(context),
//           appBar: headerNav(_drawerKey),
//           // bottomNavigationBar: bottomNav(),
//           body: Column(
//             children: <Widget>[
//               SectionHeader('Apka Bahi Khata'),
//               Container(
//                 child: Text('  Not syncing with Tally :) Swipe to delete.'),
//                 color: bmsWarningShadow,
//                 width: MediaQuery.of(context).size.width,
//               ),
//               KhataList(),
//             ],
//           ),
//           floatingActionButton: Padding(
//             padding: spacer.x.xs,
//             child: FloatingActionButton(
//                 child: Icon(Icons.add),
//                 backgroundColor: bmsPrimaryBackground,
//                 onPressed: () => null
//                 // _showKhataPanel(),
//                 ),
//           ),
//         ),
//       ),
//     );
//   }
// }
