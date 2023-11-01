import 'package:flutter/material.dart';

Future<void> displayAlert(BuildContext context , String message) {
      return showDialog<String>(context: context, builder: ( (context) => AlertDialog(
                                                      title: Text("Error"),
                                                      content: Text(message),
                                                      actions: [
                                                        TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, child: Text("OK"))
                                                      ],
    )));

    
    }



Future<void> displayLoading(BuildContext context  ) {
      return showDialog(context: context, builder: (context)=>SimpleDialog(children: [
        CircularProgressIndicator()
      ],));

    
    }


