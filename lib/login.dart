import 'package:flutter/material.dart';
import 'initial_page.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class Login extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      systemNavigationBarColor: Colors.green,
//      systemNavigationBarIconBrightness: Brightness.light,
//      //bottom bar color
//    ));

    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final double contHeight = MediaQuery.of(context).size.height / 10;
    final double contWidth = MediaQuery.of(context).size.width * 0.75;

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        radius: 48.0,
        child: Image.asset('assets/logo.jpg', fit: BoxFit.cover),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'growa@gmail.com',
      cursorColor: Colors.lightBlue,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      cursorColor: Colors.lightBlue,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = OutlineButton(
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.black,
      ),
      padding: EdgeInsets.all(12.0),
      highlightedBorderColor: Colors.white70,
      splashColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text('Log In', style: TextStyle(color: Colors.black)),
      onPressed: () {
        Navigator.of(context).pushNamed(InitialPage.tag);
      },
    );

    final signUpButton = OutlineButton(
      borderSide: BorderSide(
        width: 0.5,
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.all(12.0),
      highlightedBorderColor: Colors.white70,
      splashColor: Colors.white70,
      child: Text('Sign Up', style: TextStyle(color: Colors.black)),
      onPressed: () {
//          Navigator.of(context).pushNamed(HomePage.tag);
      },
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forget password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');

        //we need to return a future
        return Future.value(false);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.green,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            reverse: true,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: contHeight * .80,
                    ),
                    Container(
                      height: contHeight * 2.0,
                      width: contWidth,
                      child: Text(('GROWA'),
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
//                      color: Color.fromRGBO(61, 8, 89, 100),
                              fontSize: contHeight * 1.75),
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      height: contHeight * 3.0,
                      width: contWidth,
                      child: Image.asset('assets/logo.jpg'),
                    ),
                    Container(
                      height: contHeight * 0.60,
                      width: contWidth,
                      child: email,
                    ),
                    Container(
                      height: contHeight * 0.75,
                      width: contWidth,
                      child: password,
                    ),
                    Container(
                      width: contWidth * 0.5,
                      child: loginButton,
                    ),
                    Text(('or'),
                        style: TextStyle(color: Colors.black54),
                        textAlign: TextAlign.center),
                    Container(
                      width: contWidth * 0.5,
                      child: signUpButton,
                    ),
                    SizedBox(
                      height: contHeight * 0.30,
                    ),
                    forgotLabel
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
