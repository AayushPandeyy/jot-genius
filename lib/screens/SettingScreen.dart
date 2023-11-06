import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/screens/LogInPage.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context: context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Settings"),),
        body: Container(
            width: ScreenSize.screenWidth,
            height: ScreenSize.screenHeight,
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(onPressed: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: ((context) => LogInScreen())));
                    }, child: Text("Sign Out"),style: TextButton.styleFrom(
                                  textStyle: TextStyle(

                                    fontSize: 20
                                  ),
                                  primary: Colors.white,
                                  backgroundColor: Colors.black,
                                  elevation: 10,
                                  fixedSize: Size(ScreenSize.screenWidth * 0.85, ScreenSize.screenHeight*0.05),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                ),),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}