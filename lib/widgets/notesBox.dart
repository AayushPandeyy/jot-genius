import 'package:flutter/material.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'dart:math' as math;

class NotesBox extends StatefulWidget {
  final String? title;
  final String? body;

  const NotesBox({super.key, this.title, this.body});

  @override
  State<NotesBox> createState() => _NotesBoxState();
}

class _NotesBoxState extends State<NotesBox> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context: context);
    return Card(
      shape: BeveledRectangleBorder(),
      color: Colors.white,
                    
                    child: ClipPath(
                      clipper: ShapeBorderClipper(
        shape: RoundedRectangleBorder(
            )),
                      
                      child: Container(
                        padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),width: 5),)),
        
                          width: 0.45*ScreenSize.screenWidth,
                          height: 0.05*ScreenSize.screenHeight,
                          // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black,style: BorderStyle.solid),right: BorderSide(color: Colors.black),),),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(this.widget.title.toString(),style: TextStyle(fontSize:25,fontFamily: "Gabarito",fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
                              SizedBox(height: 5,),
                              Expanded(child: Text(this.widget.body.toString(),style: TextStyle(fontSize:17,fontFamily: "Arial",color: Colors.black),softWrap: true,overflow: TextOverflow.fade,)),
                              
                            ],
                          ),
                      ),
                    ),
                  );
  }
}