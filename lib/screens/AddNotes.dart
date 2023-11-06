import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jot_genius/constants/ScreenSize.dart';
import 'package:jot_genius/utilities/firestoreCRUD.dart';

class AddNotesScreen extends StatefulWidget {

  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {

  TextEditingController titleController = new TextEditingController();
  TextEditingController bodyController = new TextEditingController();

  String? currUID;

  bool isPinned = false;

  String currDate = DateFormat("MMM dd , EEE , yyyy  hh:mm:ss a").format(DateTime.now()) ;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
          await getCurrentUserId().then((value){
              setState(() {
                currUID = value;
              });
          });
  });
  }
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context: context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
                setState(() {
                  isPinned = !isPinned;
                });
            }, icon: isPinned ? Icon(Icons.push_pin,color: Colors.red,) : Icon(Icons.push_pin,),),

            IconButton(icon: Icon(Icons.done),onPressed: () {
              if(titleController.text != '' && bodyController.text != ''){
                isPinned ? FirebaseFirestore.instance.collection('users').doc(currUID).collection('Pinned').add({
                  'title' : titleController.text,
                  'body' : bodyController.text,
                  'date' : currDate,
                  'editedDate' : '',
                  "timestamp": FieldValue.serverTimestamp()
                }) : FirebaseFirestore.instance.collection('users').doc(currUID).collection('Notes').add({
                  'title' : titleController.text,
                  'body' : bodyController.text,
                  'date' : currDate,
                  'editedDate' : '',
                  "timestamp": FieldValue.serverTimestamp()
                });
                }
                Navigator.pop(context);
            },),
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                child: Text("${currDate}",style: TextStyle(fontSize: 15 , fontFamily: "Gabarito",color: Colors.grey,letterSpacing: 2)),
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
            )
          ],
        ),
      ),
    ));
  }
}