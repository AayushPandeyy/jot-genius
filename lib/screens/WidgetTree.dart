import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jot_genius/screens/HomePage.dart';
import 'package:jot_genius/screens/LogInPage.dart';


class WidgetTree extends StatefulWidget {
  
   WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

   String? username , email , phoneNumber;
  @override
  Widget build(BuildContext context) {

    // UserData? userDetails;
    
    return  StreamBuilder (stream:  FirebaseAuth.instance.authStateChanges(), builder: (context , snapshot){
          if(snapshot.hasData){
            
            return HomeScreen();
          }else{
            return LogInScreen();
          }
    });
  }
}