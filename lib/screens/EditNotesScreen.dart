import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/utilities/firestoreCRUD.dart';

class EditNotesScreen extends StatefulWidget {
  final String? title;
  final String? body;
  final String? date;
  final String? editedDate;
  final String? timeStamp;
  bool? isPinned;
  EditNotesScreen({super.key, this.title, this.body, this.date, this.editedDate , this.isPinned, this.timeStamp});

  @override
  State<EditNotesScreen> createState() => _EditNotesScreenState();
}

class _EditNotesScreenState extends State<EditNotesScreen> {
  bool? initialPinStatus;
  
  TextEditingController titleController = TextEditingController();
  
  TextEditingController bodyController =  TextEditingController();

  String? currUID;
  String? currNotesId;
  bool? pinStatus;

  @override
  void initState() {
    super.initState();
    setState(() {
      pinStatus = this.widget.isPinned;
    });
    setState(() {
      initialPinStatus = this.widget.isPinned;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async{
          await getCurrentUserId().then((value){
              setState(() {
                currUID = value;
              });
          });
          await getNoteId(this.widget.body.toString() , currUID.toString() , initialPinStatus!).then((value){
              setState(() {
                currNotesId = value;
              });
          });
  });
  }


  @override
  Widget build(BuildContext context) {
    titleController.text = this.widget.title.toString();
    bodyController.text = this.widget.body.toString();
    ScreenSize().init(context: context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              IconButton(onPressed: (){
                    setState(() {
                      if(pinStatus == true){

                      pinStatus = false;
                      }else if(pinStatus == false){
                        pinStatus = true;
                      }
                    });
              }, icon: pinStatus == true ? Icon(Icons.push_pin,color: Colors.red,) :Icon(Icons.push_pin)),
              
              IconButton(onPressed: () async{
                    Navigator.pop(context);
                    
                      await FirebaseFirestore.instance.collection('users').doc(currUID).collection('Pinned').doc(currNotesId).delete();
                    
                      
                      await FirebaseFirestore.instance.collection('users').doc(currUID).collection('Notes').doc(currNotesId).delete();

                    
              }, icon: Icon(Icons.delete)),
              IconButton(icon: Icon(Icons.done),onPressed: () {
                if(initialPinStatus == true){
                    if(pinStatus == true){
                      FirebaseFirestore.instance.collection('users').doc(currUID).collection('Pinned').doc(currNotesId).update({
                        'title' : titleController.text,
                        'body' : bodyController.text,
                        'editedDate' : DateFormat("MMM dd , EEE , yyyy  hh:mm:ss a").format(DateTime.now()).toString()
                  }) ;
                    }else{
                      FirebaseFirestore.instance.collection('users').doc(currUID).collection('Pinned').doc(currNotesId).delete();
                      FirebaseFirestore.instance.collection('users').doc(currUID).collection('Notes').add({
                  'title' : titleController.text,
                  'body' : bodyController.text,
                  'date' : this.widget.date,
                  'editedDate' : '',
                  "timestamp": this.widget.timeStamp
                });
                    }
                }else{
                  if(pinStatus == true){
                      FirebaseFirestore.instance.collection('users').doc(currUID).collection('Notes').doc(currNotesId).delete();
                      FirebaseFirestore.instance.collection('users').doc(currUID).collection('Pinned').add({
                  'title' : titleController.text,
                  'body' : bodyController.text,
                  'date' : this.widget.date,
                  'editedDate' : DateFormat("MMM dd , EEE , yyyy  hh:mm:ss a").format(DateTime.now()).toString(),
                  "timestamp": this.widget.timeStamp
                });
                    }else{
                      
                      FirebaseFirestore.instance.collection('users').doc(currUID).collection('Notes').doc(currNotesId).update({
                  'title' : titleController.text,
                  'body' : bodyController.text,
                  'date' : this.widget.date,
                  'editedDate' : DateFormat("MMM dd , EEE , yyyy  hh:mm:ss a").format(DateTime.now()).toString(),
                  "timestamp": this.widget.timeStamp
                });
                    }
                }
                  
                  Navigator.pop(context);
              },),
            ],
          ),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                child: Text("Created on : ${this.widget.date}",style: TextStyle(fontSize: 15 , fontFamily: "Gabarito",color: Colors.grey,letterSpacing: 2)),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  
                  maxLines: 1,
                  controller: titleController,
                  cursorColor: Colors.greenAccent,
                  decoration: InputDecoration(
                    
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: bodyController,
                    expands: true,
                    maxLines: null,
                    cursorColor: Colors.greenAccent,
                    
                    decoration: InputDecoration(
                      
                      hintText: "Start Typing",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:this.widget.editedDate.toString() !='' ?   Text("Last Edited on : ${this.widget.editedDate}",style: TextStyle(fontSize: 15 , fontFamily: "Gabarito",color: Colors.grey,letterSpacing: 2)) : SizedBox.shrink(),
            )
          ],
        ),
      ),
    ));
  }
}