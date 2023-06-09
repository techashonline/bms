import 'package:flutter/material.dart';
import 'package:bms/core/services/auth.dart';
import 'package:bms/theme/colors.dart';
import 'package:bms/ui/root_page.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String referralCode = '';

  @override
  Widget build(BuildContext context) {
    // return loading ? Loading() : Scaffold(
    return Scaffold(
      backgroundColor: bmsWhite,
      appBar: AppBar(
        backgroundColor: bmsPrimaryBackground,
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person,
              color: bmsWhite,
            ),
            label: Text(
              'Sign In',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: bmsWhite),
            ),
            onPressed: () => widget.toggleView!(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                    icon: Icon(Icons.email, color: bmsPrimaryBackground),
                    hintText: 'Enter your email ID please',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    labelText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key, color: bmsPrimaryBackground),
                    hintText: 'Enter your password please',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    labelText: 'Password'),
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              // TextFormField(
              //   style: Theme.of(context).textTheme.body2,
              //   decoration: InputDecoration(
              //      icon: Icon(Icons.perm_contact_calendar, color: bmsPrimaryBackground),
              //     hintText: 'Enter your referral code',
              //     hintStyle: Theme.of(context).textTheme.body2,
              //     labelText: 'Referral Code'
              //   ),
              //   obscureText: true,
              //   validator: (val) =>
              //       val.length < 6  ? 'Enter a referral code 6+ chars long' : null,
              //   onChanged: (val) {
              //     setState(() => referralCode = val);
              //   },
              // ),

              // SizedBox(height: 20.0),

              ElevatedButton(
                  // color: bmsPrimary,
                  // elevation: 10.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: bmsWhite),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RootPage(),
                          ),
                        );
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
