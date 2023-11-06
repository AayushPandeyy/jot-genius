

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jot_genius/widgets/displayAlertBox.dart';

var id;

Future<void> displaySuccess(BuildContext context , String message) {
      return showDialog<String>(context: context, builder: ( (context) => AlertDialog(
                                                      title: Text("Success"),
                                                      content: Text(message),
                                                      actions: [
                                                        TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, child: Text("OK"))
                                                      ],
    )));

    
}

void add(String username , String email , String phoneNumber,BuildContext context , var uid) async{
  id = uid;
  await FirebaseFirestore.instance.collection('users').doc(uid).
  set({
    'username' : username , 
    'email' : email , 
    'phoneNumber' : phoneNumber,
    'uid' : uid
    
  }
  ).then((value){ displaySuccess(context, "User with id ${uid} has been added.");
   }).
  catchError((err){
    displayAlert(context, "${err.toString()}");
  });
  
}





Future<void>? forgotPw({required String email , required BuildContext context}){
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

Future<String> getCurrentUserId() async{
  var currUserEmail = FirebaseAuth.instance.currentUser!.email;
  var data = await FirebaseFirestore.instance.collection('users').where('email',isEqualTo: currUserEmail).get();
  return data.docs.first.id;
}

  Future<String> getNoteId(String body , String currUID , bool pinStatus) async{
    var data;
    if(pinStatus == true){

    data = await FirebaseFirestore.instance.collection('users').doc(currUID).collection('Pinned').where('body',isEqualTo: body).get();
    }else{
      
    data = await FirebaseFirestore.instance.collection('users').doc(currUID).collection('Notes').where('body',isEqualTo: body).get();
    
    }
    return data.docs.first.id;
  }


