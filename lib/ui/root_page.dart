import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:bms/ui/widgets/welcomescreen.dart';
import 'package:bms/ui/widgets/welcomescreen2.dart';
import 'package:bms/ui/views/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bms/ui/views/home.dart';
// import 'package:bms/ui/views/menu.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Menu widget
    if (user == null) {
      return Scaffold(body: HomeScreen());
    } else {
      // return WelcomeScreen2();
      return Scaffold(body: HomeDashboardScreen());
    }
  }
}
